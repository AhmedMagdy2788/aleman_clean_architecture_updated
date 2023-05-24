import 'package:dartz/dartz.dart';

import '../datasources/raw_table_db_data_source.dart';
import '../datasources/raw_table_json_data_source.dart';
import '../models/json_files_models/station_model.dart';
import '../models/json_files_models/subcompany_json_model.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/entities/subcompany_entity.dart';
import '../../domain/repositories/stations_of_company_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/server_models/station_model.dart';
import '../models/server_models/subcompany_server_model.dart';

class StationOfCompanyRepositoryImpl implements StationOfCompanyRepository {
  final NetworkInfo networkInfo;
  final RawTableJsonDataSource jsonDataSource;
  final RawTableDBDataSource dbDataSource;
  StationOfCompanyRepositoryImpl({
    required this.networkInfo,
    required this.jsonDataSource,
    required this.dbDataSource,
  });

  ///It's the job of the Repository to get data from the DB
  ///when there is DB connection (and then to cache it locally, to json files),
  ///or to get the cached data from json files when the DB is offline.
  @override
  Future<Either<Failure, List<SubCompanyEntity>>> getSubCompanies() async {
    Either<Failure, List<SubCompanyEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<SubCompanyServerModel> dbData =
            await dbDataSource.getRawTableRows<SubCompanyServerModel>(
                "${SubCompanyServerModel.ENDPOINT}/GetAll",
                SubCompanyServerModel.fromJson);
        // jsonDataSource.updateJsonSource(SubCompanyModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<SubCompanyJSONModel> localData =
            await jsonDataSource.getRawTableRows(
                SubCompanyJSONModel.TABLENAME, SubCompanyJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<StationEntity>>> getStationOfCompany(
      String subcompanyName) async {
    Either<Failure, List<StationEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<StationServerModel> dbData =
            await dbDataSource.getRawTableRows<StationServerModel>(
                '${StationServerModel.ENDPOINT}/GetstationsOrderedByID',
                StationServerModel.fromJson,
                null,
                (stationModel) => stationModel.ownerCompany == subcompanyName);
        // jsonDataSource.updateJsonSource(StationJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<StationJSONModel> localData =
            await jsonDataSource.getRawTableRows<StationJSONModel>(
                StationJSONModel.TABLENAME,
                StationJSONModel.fromJson,
                (stationModel) => stationModel.ownerCompany == subcompanyName);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }
}

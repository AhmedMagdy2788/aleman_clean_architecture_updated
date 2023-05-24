import 'package:dartz/dartz.dart';

import '../../../../core/models/json_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/entities/tablable_entity.dart';
import '../../domain/repositories/raw_table_repository.dart';
import '../datasources/raw_table_db_data_source.dart';
import '../datasources/raw_table_json_data_source.dart';

class RawTableRepositoryImpl implements RawTableRepository {
  final NetworkInfo networkInfo;
  final RawTableJsonDataSource jsonDataSource;
  final RawTableDBDataSource dbDataSource;
  RawTableRepositoryImpl({
    required this.networkInfo,
    required this.jsonDataSource,
    required this.dbDataSource,
  });

  ///It's the job of the Repository to get data from the DB
  ///when there is DB connection (and then to cache it locally, to json files),
  ///or to get the cached data from json files when the DB is offline.
  @override
  Future<Either<Failure, List<TablableEntity>>> getRawTableRows(
      String tableName) async {
    Either<Failure, List<TablableEntity>> responce;
    // if (false) {
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<JSONModel> dbData = await dbDataSource.getRawTableRows(
            tableName, JSONModel.mapEntitytoModel[TablableEntity]!);
        jsonDataSource.updateJsonSource(tableName, dbData);
        responce = Right(dbData as List<TablableEntity>);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<JSONModel> localData = await jsonDataSource.getRawTableRows(
            tableName, JSONModel.mapEntitytoModel[TablableEntity]!);
        responce = Right(localData as List<TablableEntity>);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, void>> addRowToRawTable(
      String tableName, TablableEntity row) {
    // TODO: implement addRowToRawTable
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteRowToRawTable(String tableName, id) {
    // TODO: implement deleteRowToRawTable
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TablableEntity>>> filterRawTableRows(
      String tableName, bool Function(TablableEntity object) where) async {
    Either<Failure, List<TablableEntity>> responce;
    if (await networkInfo.isConnected) {
      try {
        List<JSONModel> dbData = await dbDataSource.getRawTableRows(
            tableName, JSONModel.mapEntitytoModel[TablableEntity]!);
        jsonDataSource.updateJsonSource(tableName, dbData);
        List<TablableEntity> dbDataEntity = dbData as List<TablableEntity>;

        responce =
            Right(dbDataEntity.where((element) => where(element)).toList());
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<JSONModel> localData = await jsonDataSource.getRawTableRows(
            tableName, JSONModel.mapEntitytoModel[TablableEntity]!);
        List<TablableEntity> localDataEntity =
            localData as List<TablableEntity>;
        responce =
            Right(localDataEntity.where((element) => where(element)).toList());
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, void>> updateRowToRawTable(
      String tableName, id, TablableEntity row) {
    // TODO: implement updateRowToRawTable
    throw UnimplementedError();
  }
}

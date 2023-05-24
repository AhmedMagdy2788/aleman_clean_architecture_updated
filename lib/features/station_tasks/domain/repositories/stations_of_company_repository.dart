import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/station_entity.dart';
import '../entities/subcompany_entity.dart';

abstract class StationOfCompanyRepository {
  Future<Either<Failure, List<StationEntity>>> getStationOfCompany(
      String subcompanyName);
  Future<Either<Failure, List<SubCompanyEntity>>> getSubCompanies();
}

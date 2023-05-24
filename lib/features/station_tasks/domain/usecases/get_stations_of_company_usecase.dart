import 'package:dartz/dartz.dart';

import '../entities/station_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../../station_tasks/domain/repositories/stations_of_company_repository.dart';

class GetStationOfCompanyUseCase
    extends UseCase<List<StationEntity>, Params<String>> {
  final StationOfCompanyRepository repository;

  GetStationOfCompanyUseCase(this.repository);
  @override
  Future<Either<Failure, List<StationEntity>>> call(
      Params<String> params) async {
    return await repository.getStationOfCompany(params.param);
  }
}

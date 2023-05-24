import 'package:dartz/dartz.dart';

import '../entities/subcompany_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../../station_tasks/domain/repositories/stations_of_company_repository.dart';

class GetSubCompaniesUseCase extends UseCase<List<SubCompanyEntity>, NoParams> {
  final StationOfCompanyRepository repository;

  GetSubCompaniesUseCase(this.repository);
  @override
  Future<Either<Failure, List<SubCompanyEntity>>> call(NoParams params) async {
    return await repository.getSubCompanies();
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/entities/tablable_entity.dart';

abstract class RawTableRepository {
  Future<Either<Failure, List<TablableEntity>>> getRawTableRows(
      String tableName);
  Future<Either<Failure, List<TablableEntity>>> filterRawTableRows(
      String tableName, bool Function(TablableEntity object) where);
  Future<Either<Failure, void>> addRowToRawTable(
      String tableName, TablableEntity row);
  Future<Either<Failure, void>> updateRowToRawTable(
      String tableName, dynamic id, TablableEntity row);
  Future<Either<Failure, void>> deleteRowToRawTable(
      String tableName, dynamic id);
}

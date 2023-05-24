// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

import '../../features/station_tasks/domain/entities/product_entity.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive nteger or zero';

abstract class Failure extends Equatable {
  final List properties;
  final String message;
  const Failure(this.message, [this.properties = const <dynamic>[]]) : super();
  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure() : super(CACHE_FAILURE_MESSAGE);
}

class AddingProductPurchaseAndSalePricesFailure extends Failure {
  final EditingProductDetailsDto editingProductDetailsDto;
  const AddingProductPurchaseAndSalePricesFailure(this.editingProductDetailsDto)
      : super("failed to add purchase and sale prices");
}

class AddingProductPurchasePriceFailure extends Failure {
  final EditingProductDetailsDto editingProductDetailsDto;
  const AddingProductPurchasePriceFailure(this.editingProductDetailsDto)
      : super("failed to add purchase price");
}

class AddingProductSalePriceFailure extends Failure {
  final EditingProductDetailsDto editingProductDetailsDto;
  const AddingProductSalePriceFailure(this.editingProductDetailsDto)
      : super("failed to add sale price");
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure() : super(INVALID_INPUT_FAILURE_MESSAGE);
}

class DBTableNotFoundFailure extends Failure {
  const DBTableNotFoundFailure() : super("DBTableNotFoundFailure");
}

class JsonFileNotFoundFailure extends Failure {
  const JsonFileNotFoundFailure() : super("JsonFileNotFoundFailure");
}

class NoDataSourceFoundFailure extends Failure {
  const NoDataSourceFoundFailure() : super("NoDataSourceFoundFailure");
}

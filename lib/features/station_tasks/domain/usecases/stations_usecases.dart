// ignore_for_file: constant_identifier_names

import 'package:dartz/dartz.dart';

import '../../../../core/entities/expanded_table.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../presentation/bloc/tablable_entities/station_details.dart';
import '../../presentation/bloc/tablable_entities/tanks_pumps_counters_tablable.dart';
import '../entities/marketing_company_entity.dart';
import '../entities/product_entity.dart';
import '../entities/tanks_pumps_counters_entity.dart';
import '../entities/customer_entity.dart';
import '../entities/customer_trucks_entity.dart';
import '../entities/station_entity.dart';
import '../repositories/station_tasks_repository.dart';

class GetDailyReportUseCase
    extends UseCase<DailyReport, Params<Map<String, dynamic>>> {
  StationTasksRepository repository;
  GetDailyReportUseCase({required this.repository});
  @override
  Future<Either<Failure, DailyReport>> call(
      Params<Map<String, dynamic>> params) async {
    return await repository.getStationDailyReport(params.param);
  }
}

class GetTanksDetailsUseCase
    extends UseCase<List<TankEntity>, Params<StationEntity>> {
  StationTasksRepository repository;
  GetTanksDetailsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<TankEntity>>> call(
      Params<StationEntity> params) async {
    return await repository.getStationTanksDetailsRows(params.param);
  }
}

class GetProductsUseCase extends UseCase<
    Map<String, Either<Failure, List<dynamic>>>, Params<StationEntity>> {
  static const String PRODUCTS_CATEGORY_EITHER = "CategoriesEither";
  static const String PRODUCTS_EITHER = "ProductsEither";
  StationTasksRepository repository;
  GetProductsUseCase({required this.repository});
  @override
  Future<Either<Failure, Map<String, Either<Failure, List<dynamic>>>>> call(
      Params<StationEntity> params) async {
    Map<String, Either<Failure, List<dynamic>>> productsDetailsLists = {};
    productsDetailsLists[PRODUCTS_EITHER] = await repository.getProductsRaw();
    productsDetailsLists[PRODUCTS_CATEGORY_EITHER] =
        await repository.getProductsCategoriesRows();

    return Right(productsDetailsLists);
  }
}

class GetProductsCommissionUseCase
    extends UseCase<List<ProductCommissionEnitity>, Params<StationEntity>> {
  StationTasksRepository repository;
  GetProductsCommissionUseCase({required this.repository});
  @override
  Future<Either<Failure, List<ProductCommissionEnitity>>> call(
      Params<StationEntity> params) async {
    return await repository.getProductsCommissionRaw(params.param);
  }
}

class GetProductsPricesUseCase extends UseCase<
    Map<String, Either<Failure, List<dynamic>>>, Params<StationEntity>> {
  static const String PURCHASE_PRICES_EITHER = "PurchasePricesList";
  static const String SALES_PRICES_EITHER = "SalesPricesList";
  StationTasksRepository repository;
  GetProductsPricesUseCase({required this.repository});
  @override
  Future<Either<Failure, Map<String, Either<Failure, List<dynamic>>>>> call(
      Params<StationEntity> params) async {
    Map<String, Either<Failure, List<dynamic>>> pricesLists = {};

    Either<Failure, List<ProductPurchasePriceEnitity>> purchasePricesEither =
        await repository.getProductsPurchasePricesRaw(params.param);

    Either<Failure, List<ProductSalePriceEnitity>> salePricesEither =
        await repository.getProductsSalePricesRaw(params.param);

    pricesLists[PURCHASE_PRICES_EITHER] = await purchasePricesEither
        .fold<Future<Either<Failure, List<ProductPurchasePriceEnitity>>>>(
            (l) async => Left(l),
            (purchasePricesList) async => Right(purchasePricesList));
    pricesLists[SALES_PRICES_EITHER] = await salePricesEither
        .fold<Future<Either<Failure, List<ProductSalePriceEnitity>>>>(
            (l) async => Left(l),
            (salePricesList) async => Right(salePricesList));
    return Right(pricesLists);
  }
}

class GetTanksContentTypeUseCase
    extends UseCase<List<TankContentTypeEntity>, Params<StationEntity>> {
  StationTasksRepository repository;
  GetTanksContentTypeUseCase({required this.repository});
  @override
  Future<Either<Failure, List<TankContentTypeEntity>>> call(
      Params<StationEntity> params) async {
    return await repository.getTanksContentTypeRows(params.param);
  }
}

class GetTanksProductsUseCase extends UseCase<List<String>, NoParams> {
  StationTasksRepository repository;
  GetTanksProductsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    var either = await repository.getTanksProductsRows();
    return either.fold(
        (l) => Left(l), (r) => Right(r.map<String>((e) => e.product).toList()));
  }
}

class GetProductsCategoriesUseCase extends UseCase<List<String>, NoParams> {
  StationTasksRepository repository;
  GetProductsCategoriesUseCase({required this.repository});
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    var either = await repository.getProductsCategoriesRows();
    return either.fold(
        (l) => Left(l),
        (categories) =>
            Right(categories.map<String>((e) => e.categoryName).toList()));
  }
}

class GetTanksDailyMeasuermentsUseCase
    extends UseCase<ExpandedTableDataSource, Params<StationEntity>> {
  StationTasksRepository repository;
  GetTanksDailyMeasuermentsUseCase({required this.repository});
  @override
  Future<Either<Failure, ExpandedTableDataSource>> call(
      Params<StationEntity> params) async {
    return await repository.getTanksDailyMeasuermentsRows(params.param);
  }
}

class GetTanksEquilibriumUseCase
    extends UseCase<ExpandedTableDataSource, Params<StationEntity>> {
  StationTasksRepository repository;
  GetTanksEquilibriumUseCase({required this.repository});
  @override
  Future<Either<Failure, ExpandedTableDataSource>> call(
      Params<StationEntity> params) async {
    return await repository.getTanksEquilibriumRows(params.param);
  }
}

class GetDailyStationStockUseCase
    extends UseCase<ExpandedTableDataSource, Params<StationEntity>> {
  StationTasksRepository repository;
  GetDailyStationStockUseCase({required this.repository});
  @override
  Future<Either<Failure, ExpandedTableDataSource>> call(
      Params<StationEntity> params) async {
    return await repository.getDailyStationStockRows(params.param);
  }
}

class GetStationCustomersUseCase
    extends UseCase<List<CustomerEntity>, Params<StationEntity>> {
  StationTasksRepository repository;
  GetStationCustomersUseCase({required this.repository});
  @override
  Future<Either<Failure, List<CustomerEntity>>> call(
      Params<StationEntity> params) async {
    return await repository.getStationCustomersRows(params.param);
  }
}

class GetCustomersTrucksUseCase
    extends UseCase<List<CustomerTruckEntity>, Params<StationEntity>> {
  StationTasksRepository repository;
  GetCustomersTrucksUseCase({required this.repository});
  @override
  Future<Either<Failure, List<CustomerTruckEntity>>> call(
      Params<StationEntity> params) async {
    return await repository.getCustomersTrucksRows(params.param);
  }
}

class GetMarketingCompaniesUseCase
    extends UseCase<List<MarketingComapnyEntity>, NoParams> {
  final StationTasksRepository repository;
  GetMarketingCompaniesUseCase(this.repository);
  @override
  Future<Either<Failure, List<MarketingComapnyEntity>>> call(
      NoParams params) async {
    return await repository.getMarketingCompaniesRows();
  }
}

class GetStationsUseCase extends UseCase<List<StationEntity>, NoParams> {
  final StationTasksRepository repository;
  GetStationsUseCase(this.repository);
  @override
  Future<Either<Failure, List<StationEntity>>> call(NoParams params) async {
    return await repository.getStatinsRows();
  }
}

class AddTankDetailseUseCase
    extends UseCase<bool, Params<Map<String, dynamic>>> {
  StationTasksRepository repository;
  AddTankDetailseUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(
      Params<Map<String, dynamic>> params) async {
    Either<Failure, int> responce = await repository.addTankDetailsRows(
        TankEntity(
            id: 0,
            name: params.param[TankTablable.NAME],
            stationName: params.param[TankTablable.STATION_NAME],
            capacity: params.param[TankTablable.CAPACITY]));
    return responce.fold<Future<Either<Failure, bool>>>(
      (l) async => Left(l),
      (r) async => await repository.addTankContentTypeRows(
        TankContentTypeEntity(
          date: params.param[TankContentTypeTablable.DATE],
          tankNo: r,
          productName: params.param[TankContentTypeTablable.PRODUCT_NAME],
        ),
      ),
    );
  }
}

class AddProductDetailsUseCase extends UseCase<EditingProductDetailsDto,
    Params<EditingProductDetailsDto>> {
  StationTasksRepository repository;
  AddProductDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, EditingProductDetailsDto>> call(
      Params<EditingProductDetailsDto> params) async {
    Either<Failure, int> responce =
        await repository.addProductRow(ProductEntity(
      productId: 0,
      productName: params.param.productName,
      productsCategory: params.param.categoryName,
    ));

    return responce.fold<Future<Either<Failure, EditingProductDetailsDto>>>(
        (l) async => Left(l), (productId) async {
      var addedProduct = params.param.copyWith(productId: productId);
      Either<Failure, bool> eitherPurchasePrice =
          await repository.addProductPurchasePrice(ProductPurchasePriceEnitity(
        date: params.param.date,
        productName: params.param.productName,
        productPurchasePrice: params.param.productPurchasePrice,
      ));

      Either<Failure, bool> eitherSalePrice =
          await repository.addProductSalePrice(ProductSalePriceEnitity(
        date: params.param.date,
        productName: params.param.productName,
        productSalePrice: params.param.productSalePrice,
      ));

      return eitherPurchasePrice
          .fold<Future<Either<Failure, EditingProductDetailsDto>>>(
              (l) async => Left(l), (isPurchasePriceAdded) async {
        return eitherSalePrice
            .fold<Future<Either<Failure, EditingProductDetailsDto>>>(
                (l) async => Left(l), (isSalePriceAdded) async {
          if (!isPurchasePriceAdded && !isSalePriceAdded) {
            return Left(
                AddingProductPurchaseAndSalePricesFailure(addedProduct));
          }
          if (!isPurchasePriceAdded) {
            return Left(AddingProductPurchasePriceFailure(addedProduct));
          }
          if (!isSalePriceAdded) {
            return Left(AddingProductSalePriceFailure(addedProduct));
          }
          return Right(addedProduct);
        });
      });
    });
  }
}

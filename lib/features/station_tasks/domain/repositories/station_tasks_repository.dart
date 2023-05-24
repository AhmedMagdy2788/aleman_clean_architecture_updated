import 'package:dartz/dartz.dart';

import '../../../../core/entities/expanded_table.dart';
import '../../../../core/error/failures.dart';
import '../../presentation/bloc/tablable_entities/station_details.dart';
import '../entities/product_entity.dart';
import '../entities/customer_trucks_entity.dart';
import '../entities/marketing_company_entity.dart';
import '../entities/station_entity.dart';
import '../entities/customer_entity.dart';
import '../entities/tanks_pumps_counters_entity.dart';

abstract class StationTasksRepository {
  Future<Either<Failure, DailyReport>> getStationDailyReport(
      Map<String, dynamic> reportParams);
  Future<Either<Failure, ExpandedTableDataSource>> getDailyStationStockRows(
      StationEntity stationEntity);

  Future<Either<Failure, List<MarketingComapnyEntity>>>
      getMarketingCompaniesRows();

  Future<Either<Failure, List<StationEntity>>> getStatinsRows();

  Future<Either<Failure, List<CustomerEntity>>> getStationCustomersRows(
      StationEntity stationEntity);
  Future<Either<Failure, List<CustomerTruckEntity>>> getCustomersTrucksRows(
      StationEntity stationEntity);

  Future<Either<Failure, List<TankEntity>>> getStationTanksDetailsRows(
      StationEntity stationEntity);
  Future<Either<Failure, List<TankProductEntity>>> getTanksProductsRows();
  Future<Either<Failure, List<TankContentTypeEntity>>> getTanksContentTypeRows(
      StationEntity stationEntity);
  Future<Either<Failure, ExpandedTableDataSource>>
      getTanksDailyMeasuermentsRows(StationEntity stationEntity);
  Future<Either<Failure, ExpandedTableDataSource>> getTanksEquilibriumRows(
      StationEntity stationEntity);
  Future<Either<Failure, int>> addTankDetailsRows(TankEntity tankEntity);
  Future<Either<Failure, bool>> addTankContentTypeRows(
      TankContentTypeEntity tankEntity);

  Future<Either<Failure, List<ProductsCategoryEnitity>>>
      getProductsCategoriesRows();
  Future<Either<Failure, List<ProductEntity>>> getProductsRaw();
  Future<Either<Failure, List<ProductCommissionEnitity>>>
      getProductsCommissionRaw(StationEntity stationEntity);
  Future<Either<Failure, List<ProductPurchasePriceEnitity>>>
      getProductsPurchasePricesRaw(StationEntity stationEntity);
  Future<Either<Failure, List<ProductSalePriceEnitity>>>
      getProductsSalePricesRaw(StationEntity stationEntity);
  Future<Either<Failure, int>> addProductRow(ProductEntity productEntity);
  Future<Either<Failure, bool>> addProductPurchasePrice(
      ProductPurchasePriceEnitity productPurchasePriceEnitity);
  Future<Either<Failure, bool>> addProductSalePrice(
      ProductSalePriceEnitity productSalePriceEnitity);
}

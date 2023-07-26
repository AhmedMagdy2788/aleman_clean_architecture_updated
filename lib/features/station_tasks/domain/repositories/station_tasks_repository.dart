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

  ///* PumpTankDetails Controller *///
  Future<Either<Failure, List<PumpTankDetailEntity>>> getPumpTankDetails();

  Future<Either<Failure, PumpTankDetailEntity>> getPumpTankDetailByIds(
      DateTime date, int pumpNo);

  Future<Either<Failure, PumpTankDetailEntity>> getPumpTanksAtGeneralDate(
      DateTime date, int pumpNo);

  Future<Either<Failure, List<PumpTankDetailEntity>>> getAllPumpInstallations(
      int pumpNo);

  Future<Either<Failure, List<PumpTankDetailEntity>>>
      getStationPumpTankDetailDtoAtGenralDate(
          String stationName, DateTime date);

  Future<Either<Failure, PumpTankDetailEntity>> postPumpsTanksDetail(
      PumpTankDetailEntity pumpTankDetailEntity);

  Future<Either<Failure, PumpTankDetailEntity>> putPumpsTanksDetail(
      DateTime date, int pumpno, PumpTankDetailEntity pumpTankDetailEntity);

  Future<Either<Failure, PumpTankDetailEntity>> deletePumpsTanksDetail(
      DateTime date, int pumpNO);

  ///* Tanks controller *///
  Future<Either<Failure, List<TankEntity>>> getAllTanks();
  Future<Either<Failure, TankEntity>> getTankByTankNO(int tankNo);
  Future<Either<Failure, List<TankEntity>>> getTanksByStationName(
      String stationName);
  Future<Either<Failure, TankEntity>> addTank(TankEntity tankEntity);
  Future<Either<Failure, List<TankEntity>>> addRangeOfTanks(
      List<TankEntity> tankEntity);
  Future<Either<Failure, TankEntity>> updateRangeOfTanks(
      int tankNo, TankEntity tankEntity);
  Future<Either<Failure, TankEntity>> deleteRangeOfTanks(int tankNo);
}

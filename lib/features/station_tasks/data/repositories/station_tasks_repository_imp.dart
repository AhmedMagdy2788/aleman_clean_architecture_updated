import 'dart:developer';

import 'package:aleman_clean_architecture_updated/core/models/json_model.dart';
import 'package:aleman_clean_architecture_updated/core/models/server_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/expanded_table.dart';
import '../../../../core/entities/expanded_row_entity.dart';
import '../../../../core/entities/tablable_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_trucks_entity.dart';
import '../../domain/entities/marketing_company_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/entities/tanks_pumps_counters_entity.dart';
import '../../presentation/bloc/tablable_entities/station_details.dart';
import '../../domain/repositories/station_tasks_repository.dart';
import '../datasources/raw_table_db_data_source.dart';
import '../datasources/raw_table_json_data_source.dart';
import '../models/json_files_models/customer_json_model.dart';
import '../models/json_files_models/customer_trucks_json_model.dart';
import '../models/json_files_models/marketing_company_model.dart';
import '../models/json_files_models/product_json_model.dart';
import '../models/json_files_models/station_model.dart';
import '../models/json_files_models/tank_json_model.dart';
import '../models/server_models/customer_server_model.dart';
import '../models/server_models/customer_trucks_server_model.dart';
import '../models/server_models/marketing_company_model.dart';
import '../models/server_models/product_server_model.dart';
import '../models/server_models/station_model.dart';
import '../models/server_models/tank_server_model.dart';

class StationTasksRepositoryImpl implements StationTasksRepository {
  final NetworkInfo networkInfo;
  final RawTableJsonDataSource jsonDataSource;
  final RawTableDBDataSource dbDataSource;
  StationTasksRepositoryImpl({
    required this.networkInfo,
    required this.jsonDataSource,
    required this.dbDataSource,
  });

  @override
  Future<Either<Failure, DailyReport>> getStationDailyReport(
      Map<String, dynamic> reportParams) async {
    Either<Failure, DailyReport> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        DailyReport dbDailyReport = await dbDataSource.getDailyReport(
            reportParams["station"], reportParams["date"]);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbDailyReport);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        var report = DailyReport(
          currentDate: reportParams["date"],
          stationDetails: StationDetails(
            station: reportParams["station"],
            tanks: {
              1: "tank 1",
              2: "tank 2",
              3: "tank 3",
              4: "tank 4",
              5: "tank 5",
              6: "tank 6"
            },
          ),
        );
        report.prevDate = DateTime(2023, 3, 18);
        report.currentTanksMeasurments =
            ExpandedRowEntity(id: DateTime(2023, 3, 20), rowData: {
          "tank 1": 11243,
          "tank 2": 2948,
          "tank 3": 8978,
          "tank 4": 23948,
          "tank 5": 23948,
          "tank 6": 23948
        });
        report.prevTanksMeasurments =
            ExpandedRowEntity(id: DateTime(2023, 3, 18), rowData: {
          "tank 1": 23243,
          "tank 2": 3948,
          "tank 3": 8948,
          "tank 4": 23348,
          "tank 5": 25948,
          "tank 6": 23978
        });

        responce = await Future.delayed(
          Duration.zero,
          () {
            return Right(report);
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsRaw() async {
    // log(stationEntity.toString());
    Either<Failure, List<ProductEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<ProductServerModel> dbData = await dbDataSource.getRawTableRows(
            '${ProductServerModel.ENDPOINT}/GetTblProductsWithCategoryName',
            ProductServerModel.fromMap);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<ProductJSONModel> localData = await jsonDataSource.getRawTableRows(
            ProductJSONModel.TABLENAME, ProductJSONModel.fromMap);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<ProductCommissionEnitity>>>
      getProductsCommissionRaw(StationEntity stationEntity) async {
    log(stationEntity.toString());
    Either<Failure, List<ProductCommissionEnitity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<ProductCommissionServerModel> dbData =
            await dbDataSource.getRawTableRows(
                '${ProductCommissionServerModel.ENDPOINT}/GetWithName',
                ProductCommissionServerModel.fromMap,
                '?stationName=${stationEntity.name}');
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        throw UnimplementedError();
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<ProductPurchasePriceEnitity>>>
      getProductsPurchasePricesRaw(StationEntity stationEntity) async {
    log(stationEntity.toString());
    Either<Failure, List<ProductPurchasePriceServerModel>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<ProductPurchasePriceServerModel> dbData =
            await dbDataSource.getRawTableRows(
                '${ProductPurchasePriceServerModel.ENDPOINT}/ProductsPurchasePricesWithProductName',
                ProductPurchasePriceServerModel.fromMap,
                '?stationName=${stationEntity.name}');
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        throw UnimplementedError();
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<ProductSalePriceEnitity>>>
      getProductsSalePricesRaw(StationEntity stationEntity) async {
    log(stationEntity.toString());
    Either<Failure, List<ProductSalePriceServerModel>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<ProductSalePriceServerModel> dbData =
            await dbDataSource.getRawTableRows(
                '${ProductSalePriceServerModel.ENDPOINT}/ProductsSalePricesWithProductName',
                ProductSalePriceServerModel.fromMap,
                '?stationName=${stationEntity.name}');
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        throw UnimplementedError();
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<CustomerEntity>>> getStationCustomersRows(
      StationEntity stationEntity) async {
    log(stationEntity.toString());
    Either<Failure, List<CustomerEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<CustomerServerModel> dbData = await dbDataSource.getRawTableRows(
            '${CustomerServerModel.ENDPOINT}/GetStationCustomers',
            CustomerServerModel.fromJson,
            '?station_name=${stationEntity.name}');
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<CustomerJSONModel> localData =
            await jsonDataSource.getRawTableRows(
                CustomerJSONModel.TABLENAME, CustomerJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<CustomerTruckEntity>>> getCustomersTrucksRows(
      StationEntity stationEntity) async {
    log(stationEntity.toString());
    Either<Failure, List<CustomerTruckEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<CustomerTruckServerModel> dbData =
            await dbDataSource.getRawTableRows(
                '${CustomerTruckServerModel.ENDPOINT}/GetStationCustomersTrucks',
                CustomerTruckServerModel.fromJson,
                '?stationName=${stationEntity.name}');
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<CustomerTruckJSONModel> localData =
            await jsonDataSource.getRawTableRows(
                CustomerTruckJSONModel.TABLENAME,
                CustomerTruckJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<MarketingComapnyEntity>>>
      getMarketingCompaniesRows() async {
    Either<Failure, List<MarketingComapnyEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<MarketingComapnyServerModel> dbData =
            await dbDataSource.getRawTableRows<MarketingComapnyServerModel>(
                '${MarketingComapnyServerModel.ENDPOINT}/GetAll',
                MarketingComapnyServerModel.fromJson);
        // jsonDataSource.updateJsonSource(SubCompanyModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<MarketingComapnyJSONModel> localData =
            await jsonDataSource.getRawTableRows(
                MarketingComapnyJSONModel.TABLENAME,
                MarketingComapnyJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<StationEntity>>> getStatinsRows() async {
    Either<Failure, List<StationEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<StationServerModel> dbData =
            await dbDataSource.getRawTableRows<StationServerModel>(
                'Stations/GetstationsOrderedByID', StationServerModel.fromJson);
        // jsonDataSource.updateJsonSource(SubCompanyModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<StationJSONModel> localData = await jsonDataSource.getRawTableRows(
            StationJSONModel.TABLENAME, StationJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<TankContentTypeEntity>>> getTanksContentTypeRows(
      StationEntity stationEntity) async {
    log(stationEntity.toString());
    Either<Failure, List<TankContentTypeEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<TankContaintTypeServerModel> dbData =
            await dbDataSource.getRawTableRows(
                '${TankContaintTypeServerModel.ENDPOINT}/GetTanksContentTypeByStationName',
                TankContaintTypeServerModel.fromJson,
                '?stationName=${stationEntity.name}');
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<TankContaintTypeJSONModel> localData =
            await jsonDataSource.getRawTableRows(
                TankContaintTypeJSONModel.TABLENAME,
                TankContaintTypeJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<TankProductEntity>>>
      getTanksProductsRows() async {
    Either<Failure, List<TankProductEntity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<TankProductServerModel> dbData =
            await dbDataSource.getRawTableRows(
                '${TankProductServerModel.ENDPOINT}/GetTanksProducts',
                TankProductServerModel.fromJson);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<TankProductJSONModel> localData =
            await jsonDataSource.getRawTableRows(
                TankProductJSONModel.TABLENAME, TankProductJSONModel.fromJson);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, List<ProductsCategoryEnitity>>>
      getProductsCategoriesRows() async {
    Either<Failure, List<ProductsCategoryEnitity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<ProductsCategoryServerModel> dbData =
            await dbDataSource.getRawTableRows(
                ProductsCategoryServerModel.ENDPOINT,
                ProductsCategoryServerModel.fromMap);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        throw UnimplementedError();
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, ExpandedTableDataSource>>
      getTanksDailyMeasuermentsRows(StationEntity stationEntity) async {
    Either<Failure, ExpandedTableDataSource> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<TablableEntity<Map<String, dynamic>>> dataRows = [];
        List<Map<String, dynamic>> jsonDataList =
            await dbDataSource.getRawExpandedTableRows(
                'TanksQuantities/GetExpandedTanksQuantityByStationName',
                '?stationName=${stationEntity.name}');
        for (var element in jsonDataList) {
          dataRows.add(ExpandedRowEntity(
              rowData: element, id: element["registeration_Date"]));
        }
        Map<String, Type> columns = {};
        jsonDataList[0].forEach((key, value) {
          columns[key] = value.runtimeType;
        });
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        ExpandedTableDataSource dbData = ExpandedTableDataSource(
          title: "Daily Tanks Measurments",
          dataList: dataRows,
          columns: columns,
        );
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        // List<TablableEntity<Map<String, dynamic>>> localData =
        // await jsonDataSource.getRawTableRows(
        //     TankContaintTypeJSONModel.TABLENAME,
        //     TankContaintTypeJSONModel.fromJson);
        responce = await Future.delayed(Duration.zero)
            .then<Either<Failure, ExpandedTableDataSource>>(
          (value) {
            return Right(ExpandedTableDataSource(
              title: "Daily Tanks Measurments",
              dataList: [
                ExpandedRowEntity(id: DateTime.now(), rowData: {
                  "date": DateTime.now(),
                  "tank 1": 3434.23,
                  "tank 2": 2343.34,
                  "tank 3": 46453.34,
                  "tank 4": 24536.4,
                  "tank 5": 245667.55,
                  "tank 6": 7856.54,
                }),
                ExpandedRowEntity(id: DateTime.now(), rowData: {
                  "date": DateTime.now(),
                  "tank 1": 3434.23,
                  "tank 2": 2343.34,
                  "tank 3": 46453.34,
                  "tank 4": 24536.4,
                  "tank 5": 245667.55,
                  "tank 6": 7856.54,
                }),
                ExpandedRowEntity(id: DateTime.now(), rowData: {
                  "date": DateTime.now(),
                  "tank 1": 3434.23,
                  "tank 2": 2343.34,
                  "tank 3": 46453.34,
                  "tank 4": 24536.4,
                  "tank 5": 245667.55,
                  "tank 6": 7856.54,
                }),
                ExpandedRowEntity(id: DateTime.now(), rowData: {
                  "date": DateTime.now(),
                  "tank 1": 3434.23,
                  "tank 2": 2343.34,
                  "tank 3": 46453.34,
                  "tank 4": 24536.4,
                  "tank 5": 245667.55,
                  "tank 6": 7856.54,
                }),
                ExpandedRowEntity(id: DateTime.now(), rowData: {
                  "date": DateTime.now(),
                  "tank 1": 3434.23,
                  "tank 2": 2343.34,
                  "tank 3": 46453.34,
                  "tank 4": 24536.4,
                  "tank 5": 245667.55,
                  "tank 6": 7856.54,
                }),
              ],
              columns: {
                "date": DateTime,
                "tank 1": double,
                "tank 2": double,
                "tank 3": double,
                "tank 4": double,
                "tank 5": double,
                "tank 7": double,
              },
            ));
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, ExpandedTableDataSource>> getTanksEquilibriumRows(
      StationEntity stationEntity) async {
    Either<Failure, ExpandedTableDataSource> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<TablableEntity<Map<String, dynamic>>> dataRows = [];
        List<Map<String, dynamic>> jsonDataList =
            await dbDataSource.getRawExpandedTableRows(
                'TanksEquilibrium/GetExpandedTanksEquilibriumByStationName',
                '?stationName=${stationEntity.name}');
        for (var element in jsonDataList) {
          dataRows
              .add(ExpandedRowEntity(rowData: element, id: element["date"]));
        }
        Map<String, Type> columns = {};
        jsonDataList[0].forEach((key, value) {
          columns[key] = value.runtimeType;
        });
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        ExpandedTableDataSource dbData = ExpandedTableDataSource(
          title: "Daily Tanks Equilibrium",
          dataList: dataRows,
          columns: columns,
        );
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        // List<TablableEntity<Map<String, dynamic>>> localData =
        // await jsonDataSource.getRawTableRows(
        //     TankContaintTypeJSONModel.TABLENAME,
        //     TankContaintTypeJSONModel.fromJson);
        responce = await Future.delayed(Duration.zero)
            .then<Either<Failure, ExpandedTableDataSource>>(
          (value) {
            return Right(ExpandedTableDataSource(
              title: "Daily Tanks Equilibrium",
              dataList: [
                ExpandedRowEntity(id: DateTime.now(), rowData: {
                  "date": DateTime.now(),
                  "سولار": 3434.23,
                  "بنزين 92": 2343.34,
                  "بنزين 80": 46453.34,
                  "ملاحظات": "test data",
                }),
              ],
              columns: {
                "date": DateTime,
                "سولار": double,
                "بنزين 92": double,
                "بنزين 80": double,
                "ملاحظات": String,
              },
            ));
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, ExpandedTableDataSource>> getDailyStationStockRows(
      StationEntity stationEntity) async {
    return await Future.delayed(Duration.zero)
        .then<Either<Failure, ExpandedTableDataSource>>(
      (value) {
        return Right(ExpandedTableDataSource(
          title: "Daily Station Stock",
          dataList: [
            ExpandedRowEntity(id: DateTime.now(), rowData: {
              "date": DateTime.now(),
              "سولار": 3434.23,
              "بنزين 92": 2343.34,
              "بنزين 80": 46453.34,
              "ملاحظات": "test data",
            }),
          ],
          columns: {
            "date": DateTime,
            "سولار": double,
            "بنزين 92": double,
            "بنزين 80": double,
            "ملاحظات": String,
          },
        ));
      },
    );
  }

  @override
  Future<Either<Failure, bool>> addTankContentTypeRows(
      TankContentTypeEntity tankEntity) async {
    Either<Failure, bool> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        TankContaintTypeServerModel addObject =
            await dbDataSource.addRowToRawTable(
                '${TankContaintTypeServerModel.ENDPOINT}/AddtankContentType',
                TankContaintTypeServerModel(
                    date: tankEntity.date,
                    productName: tankEntity.productName,
                    tankNo: tankEntity.tankNo),
                TankContaintTypeServerModel
                    .fromJson);
        // responce = Right((addObject == tankEntity) ? true : false);
        responce = const Right(true);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        responce =
            await Future.delayed(Duration.zero).then<Either<Failure, bool>>(
          (value) {
            return const Right(false);
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, int>> addTankDetailsRows(TankEntity tankEntity) async {
    Either<Failure, int> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        TankServerModel addObject = await dbDataSource.addRowToRawTable(
            'Tanks/Addtank',
            TankServerModel(
                id: tankEntity.id,
                name: tankEntity.name,
                stationName: tankEntity.stationName,
                capacity: tankEntity.capacity),
            TankServerModel.fromJson);
        responce = Right(addObject.id);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        responce =
            await Future.delayed(Duration.zero).then<Either<Failure, int>>(
          (value) {
            return const Right(-1);
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, int>> addProductRow(
      ProductEntity productEntity) async {
    Either<Failure, int> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        //api/Products/PostTblProductWithWithCategoryName
        ///api/Products/Post_TblProduct_With_Category_Name
        ProductServerModel addObject = await dbDataSource.addRowToRawTable(
            '${ProductServerModel.ENDPOINT}/Add_Product_With_Category_Name',
            ProductServerModel(
                productId: productEntity.productId,
                productName: productEntity.productName,
                productsCategory: productEntity.productsCategory),
            ProductServerModel.fromMap);
        // responce = Right((addObject == tankEntity) ? true : false);
        responce = Right(addObject.productId);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        responce =
            await Future.delayed(Duration.zero).then<Either<Failure, int>>(
          (value) {
            throw UnimplementedError();
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, bool>> addProductPurchasePrice(
      ProductPurchasePriceEnitity productPurchasePriceEnitity) async {
    Either<Failure, bool> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        //api/Products/PostTblProductWithWithCategoryName
        ProductPurchasePriceServerModel addObject =
            await dbDataSource.addRowToRawTable(
          '${ProductPurchasePriceServerModel.ENDPOINT}/Add_with_product_name',
          ProductPurchasePriceServerModel(
            date: productPurchasePriceEnitity.date,
            productName: productPurchasePriceEnitity.productName,
            productPurchasePrice:
                productPurchasePriceEnitity.productPurchasePrice,
          ),
          ProductPurchasePriceServerModel.fromMap,
        );
        // responce = Right((addObject == tankEntity) ? true : false);
        responce = const Right(true);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        responce =
            await Future.delayed(Duration.zero).then<Either<Failure, bool>>(
          (value) {
            throw UnimplementedError();
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  @override
  Future<Either<Failure, bool>> addProductSalePrice(
      ProductSalePriceEnitity productSalePriceEnitity) async {
    Either<Failure, bool> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        //api/Products/PostTblProductWithWithCategoryName
        ProductSalePriceServerModel addObject =
            await dbDataSource.addRowToRawTable(
          '${ProductSalePriceServerModel.ENDPOINT}/Add_with_product_name',
          ProductSalePriceServerModel(
            date: productSalePriceEnitity.date,
            productName: productSalePriceEnitity.productName,
            productSalePrice: productSalePriceEnitity.productSalePrice,
          ),
          ProductSalePriceServerModel.fromMap,
        );
        // responce = Right((addObject == tankEntity) ? true : false);
        responce = const Right(true);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        responce =
            await Future.delayed(Duration.zero).then<Either<Failure, bool>>(
          (value) {
            throw UnimplementedError();
          },
        );
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  ///* Tanks Controller Implementation///

  @override
  Future<Either<Failure, List<TankEntity>>> getAllTanks() async {
    return await _getListOfEntities<TankEntity>(
      serverEndPoint: TankServerModel.GetAll,
      jsonEndpoint: CustomerJSONModel.TABLENAME,
      serverCreateObject: TankServerModel.fromJson,
      jsonCreateObject: TankJSONModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, TankEntity>> getTankByTankNO(int tankNo) {
    // TODO: implement getTankByTankNO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TankEntity>>> getTanksByStationName(
      String stationName) async {
    // TODO: implement getTankByTankNO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TankEntity>> addTank(TankEntity tankEntity) async {
    // TODO: implement getTankByTankNO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TankEntity>>> addRangeOfTanks(
      List<TankEntity> tankEntity) async {
    // TODO: implement getTankByTankNO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TankEntity>> updateRangeOfTanks(
      int tankNo, TankEntity tankEntity) async {
    // TODO: implement getTankByTankNO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TankEntity>> deleteRangeOfTanks(int tankNo) async {
    // TODO: implement getTankByTankNO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TankEntity>>> getStationTanksDetailsRows(
      StationEntity stationEntity) async {
    return await _getListOfEntities<TankEntity>(
      serverEndPoint: '${TankServerModel.ENDPOINT}/GetByStationName',
      jsonEndpoint: CustomerJSONModel.TABLENAME,
      serverCreateObject: TankServerModel.fromJson,
      jsonCreateObject: TankJSONModel.fromJson,
      requestParams: '?stationName=${stationEntity.name}',
    );
  }

  ///* PumpTankDetails controller Implementation *///
  @override
  Future<Either<Failure, List<PumpTankDetailEntity>>>
      getPumpTankDetails() async {
    return await _getListOfEntities<PumpTankDetailEntity>(
      serverEndPoint: PumpTankDetailServerModel.ENDPOINT,
      jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
      serverCreateObject: PumpTankDetailServerModel.fromJson,
      jsonCreateObject: PumpTankDetailJSONModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, List<PumpTankDetailEntity>>> getAllPumpInstallations(
      int pumpNo) async {
    return await _getListOfEntities<PumpTankDetailEntity>(
        serverEndPoint: PumpTankDetailServerModel.ENDPOINT +
            PumpTankDetailServerModel.GetAllPumpInstallations,
        jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
        serverCreateObject: PumpTankDetailServerModel.fromJson,
        jsonCreateObject: PumpTankDetailJSONModel.fromJson,
        requestParams: "?pumpNo=$pumpNo");
  }

  @override
  Future<Either<Failure, PumpTankDetailEntity>> getPumpTankDetailByIds(
      DateTime date, int pumpNo) async {
    //?date=2020-10-31&pumpNo=1
    return await _getEntity<PumpTankDetailEntity>(
        serverEndPoint: PumpTankDetailServerModel.ENDPOINT +
            PumpTankDetailServerModel.GetPumpsTanksDetailById,
        jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
        serverCreateObject: PumpTankDetailServerModel.fromJson,
        jsonCreateObject: PumpTankDetailJSONModel.fromJson,
        requestParams: "?date=${date.toIso8601String()}&pumpNo=$pumpNo");
  }

  @override
  Future<Either<Failure, List<PumpTankDetailDtoEntity>>>
      getStationPumpTankDetailDtoAtGenralDate(
          String stationName, DateTime date) async {
    return await _getListOfEntities<PumpTankDetailDtoEntity>(
        serverEndPoint: PumpTankDetailDtoServerModel.ENDPOINT +
            PumpTankDetailDtoServerModel
                .GetStationPumpTankDetailDtoAtGenralDate,
        jsonEndpoint: PumpTankDetailDtoJSONModel.TABLENAME,
        serverCreateObject: PumpTankDetailDtoServerModel.fromJson,
        jsonCreateObject: PumpTankDetailDtoJSONModel.fromJson,
        requestParams:
            "?stationName=$stationName&date=${date.toIso8601String()}");
  }

  @override
  Future<Either<Failure, PumpTankDetailEntity>> getPumpTanksAtGeneralDate(
      DateTime date, int pumpNo) async {
    return await _getEntity<PumpTankDetailEntity>(
        serverEndPoint: PumpTankDetailServerModel.ENDPOINT +
            PumpTankDetailServerModel.GetPumpTanksAtGeneralDate,
        jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
        serverCreateObject: PumpTankDetailServerModel.fromJson,
        jsonCreateObject: PumpTankDetailJSONModel.fromJson,
        requestParams: "?date=${date.toIso8601String()}&pumpNo=$pumpNo");
  }

  @override
  Future<Either<Failure, PumpTankDetailEntity>> postPumpsTanksDetail(
      PumpTankDetailEntity pumpTankDetailEntity) async {
    return await _addEntity<PumpTankDetailEntity>(
      serverEntity: PumpTankDetailServerModel.fromEntity(pumpTankDetailEntity),
      jsonEntity: PumpTankDetailJSONModel.fromEntity(pumpTankDetailEntity),
      serverEndPoint: PumpTankDetailServerModel.ENDPOINT,
      jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
      serverCreateObject: PumpTankDetailServerModel.fromJson,
      jsonCreateObject: PumpTankDetailJSONModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, PumpTankDetailEntity>> putPumpsTanksDetail(
      DateTime date,
      int pumpno,
      PumpTankDetailEntity pumpTankDetailEntity) async {
    return await _updateEntity<PumpTankDetailEntity>(
      id: {
        PumpTankDetailServerModel.DATE: date,
        PumpTankDetailServerModel.PUMP_NO: pumpno
      },
      serverEntity: PumpTankDetailServerModel.fromEntity(pumpTankDetailEntity),
      jsonEntity: PumpTankDetailJSONModel.fromEntity(pumpTankDetailEntity),
      serverEndPoint: PumpTankDetailServerModel.ENDPOINT,
      jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
      serverCreateObject: PumpTankDetailServerModel.fromJson,
      jsonCreateObject: PumpTankDetailJSONModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, PumpTankDetailEntity>> deletePumpsTanksDetail(
      DateTime date, int pumpNO) async {
    return await _deleteEntity<PumpTankDetailEntity>(
      id: {
        PumpTankDetailServerModel.DATE: date,
        PumpTankDetailServerModel.PUMP_NO: pumpNO
      },
      serverEndPoint: PumpTankDetailServerModel.ENDPOINT,
      jsonEndpoint: PumpTankDetailJSONModel.TABLENAME,
      serverCreateObject: PumpTankDetailServerModel.fromJson,
      jsonCreateObject: PumpTankDetailJSONModel.fromJson,
    );
  }

  ///* Gerneral Methods *///

  Future<Either<Failure, List<Entity>>> _getListOfEntities<Entity>({
    required String serverEndPoint,
    required String jsonEndpoint,
    required Entity Function(Map<String, dynamic>) serverCreateObject,
    required Entity Function(Map<String, dynamic>) jsonCreateObject,
    String? requestParams,
  }) async {
    Either<Failure, List<Entity>> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        List<Entity> dbData = await dbDataSource.getRawTableRows(
            serverEndPoint, serverCreateObject, requestParams);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        List<Entity> localData = await jsonDataSource.getRawTableRows(
            jsonEndpoint, jsonCreateObject);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  Future<Either<Failure, Entity>> _getEntity<Entity>({
    required String serverEndPoint,
    required String jsonEndpoint,
    required Entity Function(Map<String, dynamic>) serverCreateObject,
    required Entity Function(Map<String, dynamic>) jsonCreateObject,
    String? requestParams,
  }) async {
    Either<Failure, Entity> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        Entity dbData = await dbDataSource.getRawTableRow(
            serverEndPoint, serverCreateObject, requestParams ?? "");
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        Entity localData =
            await jsonDataSource.getRawTableRow(jsonEndpoint, jsonCreateObject);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  Future<Either<Failure, Entity>> _addEntity<Entity>({
    required ServerModel serverEntity,
    required JSONModel jsonEntity,
    required String serverEndPoint,
    required String jsonEndpoint,
    required Entity Function(Map<String, dynamic>) serverCreateObject,
    required Entity Function(Map<String, dynamic>) jsonCreateObject,
  }) async {
    Either<Failure, Entity> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        Entity dbData = await dbDataSource.addRowToRawTable<Entity>(
            serverEndPoint, serverEntity, serverCreateObject);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        Entity localData = await jsonDataSource.addRowToRawTable<Entity>(
            jsonEndpoint, jsonEntity, jsonCreateObject, null);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  Future<Either<Failure, Entity>> _updateEntity<Entity>({
    required ServerModel serverEntity,
    required JSONModel jsonEntity,
    required Map<String, dynamic> id,
    required String serverEndPoint,
    required String jsonEndpoint,
    required Entity Function(Map<String, dynamic>) serverCreateObject,
    required Entity Function(Map<String, dynamic>) jsonCreateObject,
  }) async {
    Either<Failure, Entity> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        Map<String, String> headers = {};
        id.forEach((key, value) {
          headers[key] = value.toString();
        });
        Entity dbData = await dbDataSource.updateRowToRawTable<Entity>(
            serverEndPoint, id, serverEntity, serverCreateObject, headers);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        Entity localData = await jsonDataSource.updateRowToRawTable<Entity>(
            jsonEndpoint, id, jsonEntity, jsonCreateObject);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  Future<Either<Failure, Entity>> _deleteEntity<Entity>({
    required Map<String, dynamic> id,
    required String serverEndPoint,
    required String jsonEndpoint,
    required Entity Function(Map<String, dynamic>) serverCreateObject,
    required Entity Function(Map<String, dynamic>) jsonCreateObject,
  }) async {
    Either<Failure, Entity> responce;
    if (await networkInfo.isConnected) {
      //should call the remot data source to get number trivia
      try {
        Map<String, String> headers = {};
        id.forEach((key, value) {
          headers[key] = value.toString();
        });
        Entity dbData = await dbDataSource.deleteRowToRawTable<Entity>(
            serverEndPoint, id, serverCreateObject, headers);
        // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
        responce = Right(dbData);
      } catch (e) {
        responce = Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        Entity localData = await jsonDataSource.deleteRowToRawTable<Entity>(
            jsonEndpoint, id, jsonCreateObject);
        responce = Right(localData);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
    return responce;
  }

  // Future<Either<Failure, List<T>>> _getRawData<T>(String mainUri,
  //     String uriParams, T Function(Map<String, dynamic>) createFn) async {
  //   Either<Failure, List<T>> responce;
  //   if (await networkInfo.isConnected) {
  //     //should call the remot data source to get number trivia
  //     try {
  //       List<T> dbData =
  //           await dbDataSource.getRawTableRows<T>(mainUri, createFn, uriParams);
  //       // jsonDataSource.updateJsonSource(CustomerJSONModel.TABLENAME, dbData);
  //       responce = Right(dbData);
  //     } on ServerException {
  //       responce = const Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       List<T> localData = await jsonDataSource.getRawTableRows(
  //           TankContaintTypeJSONModel.TABLENAME,
  //           TankContaintTypeJSONModel.fromJson);
  //       responce = Right(localData);
  //     } on CacheException {
  //       return const Left(CacheFailure());
  //     }
  //   }
  //   return responce;
  // }
}

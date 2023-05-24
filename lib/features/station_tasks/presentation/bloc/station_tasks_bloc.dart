import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/expanded_table.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_trucks_entity.dart';
import '../../domain/entities/marketing_company_entity.dart';
import '../../domain/entities/subcompany_entity.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/entities/tanks_pumps_counters_entity.dart';
import '../../domain/usecases/get_subcompanies_usecase.dart';
import '../../domain/usecases/stations_usecases.dart';
import '../../domain/entities/product_entity.dart';
import '../pages/station_bodys/add_products_page.dart';
import '../pages/station_bodys/add_tanks_details_page.dart';
import '../pages/station_bodys/correlated_paginated_tables.dart';
import '../pages/station_bodys/daily_report_page.dart';
import '../pages/station_bodys/dashboard_page.dart';
import '../pages/station_bodys/single_expanded_paginated_table.dart';
import '../pages/station_bodys/single_paginated_table.dart';
import '../pages/station_page.dart';
import '../widgets/message_disply_widget.dart';
import 'tablable_entities/product_tablable.dart';
import 'tablable_entities/station_details.dart';
import 'tablable_entities/customer_tablable.dart';
import 'tablable_entities/customer_trucks_tablable.dart';
import 'tablable_entities/marketing_company_tablable.dart';
import 'tablable_entities/subcompany_tablable.dart';
import 'tablable_entities/station_tablable.dart';
import 'tablable_entities/tanks_pumps_counters_tablable.dart';

part 'station_tasks_event.dart';
part 'station_tasks_state.dart';

class StationTasksBloc extends Bloc<StationTasksEvent, StationTasksState> {
  final GetDailyReportUseCase getDailyReportUseCase;
  final GetDailyStationStockUseCase getDailyStationStockUseCase;

  final GetMarketingCompaniesUseCase getMarketingCompaniesUseCase;

  final GetSubCompaniesUseCase getSubCompaniesUseCase;

  final GetStationsUseCase getStationsUseCase;

  final GetStationCustomersUseCase getStationCustomersUseCase;
  final GetCustomersTrucksUseCase getCustomersTrucksUseCase;

  final GetTanksDetailsUseCase getTanksDetailsUseCase;
  final GetTanksContentTypeUseCase getTanksContentTypeUseCase;
  final GetTanksProductsUseCase getTanksProductsUseCase;
  final GetTanksDailyMeasuermentsUseCase getTanksDailyMeasuermentsUseCase;
  final GetTanksEquilibriumUseCase getTanksEquilibriumUseCase;
  final AddTankDetailseUseCase addTankDetailseUseCase;

  final GetProductsUseCase getProductsUseCase;
  final GetProductsCommissionUseCase getProductsCommissionUseCase;
  final AddProductDetailsUseCase addProductDetailsUseCase;
  final GetProductsCategoriesUseCase getProductsCategoriesUseCase;
  final GetProductsPricesUseCase getProductsPricesUseCase;

  StationTasksBloc({
    required this.getDailyReportUseCase,
    required this.getDailyStationStockUseCase,
    required this.getMarketingCompaniesUseCase,
    required this.getSubCompaniesUseCase,
    required this.getStationsUseCase,
    required this.getStationCustomersUseCase,
    required this.getCustomersTrucksUseCase,
    required this.getTanksDetailsUseCase,
    required this.getTanksContentTypeUseCase,
    required this.getTanksProductsUseCase,
    required this.getTanksDailyMeasuermentsUseCase,
    required this.getTanksEquilibriumUseCase,
    required this.addTankDetailseUseCase,
    required this.addProductDetailsUseCase,
    required this.getProductsUseCase,
    required this.getProductsCommissionUseCase,
    required this.getProductsCategoriesUseCase,
    required this.getProductsPricesUseCase,
  }) : super(StationTasksInitial()) {
    on<ShowDashboardEvent>((event, emit) {
      emit(LoadingDashboardState());
    });

    on<ShowDailyReportPageEvent>((event, emit) {
      emit(LoadingDailyReportState(event));
    });
    on<GetDailyReportEvent>((event, emit) async {
      emit(await getDailyReportEvent(event));
    });
    on<LoadDailyStationStockEvent>((event, emit) {
      emit(LoadingDailyStationStockState());
    });
    on<GetDailyStationStockEvent>((event, emit) async {
      emit(await getDailyStationStockEvent(event));
    });

    on<LoadSubCompaniesEvent>((event, emit) {
      emit(LoadingSubCompaniesState());
    });
    on<GetSubCompaniesListEvent>((event, emit) async {
      emit(await getSubCompaniesListEvent(event));
    });

    on<LoadMarketingCompaniesEvent>((event, emit) {
      emit(LoadingMarketingCompaniesState());
    });
    on<GetMarketingCompaniesEvent>((event, emit) async {
      emit(await getMarketingCompaniesEvent(event));
    });

    on<LoadStationsEvent>((event, emit) {
      emit(LoadingStationsState());
    });
    on<GetStationsEvent>((event, emit) async {
      emit(await getStationsListEvent(event));
    });

    on<LoadStationCustomersEvent>((event, emit) {
      emit(LoadingStationCustomersState());
    });
    on<GetStationCustomersListEvent>((event, emit) async {
      emit(await getStationCustomersList(event));
    });
    on<LoadAddCustomerEvent>((event, emit) {
      emit(LoadingAddCustomerState());
    });

    on<LoadTanksEditingEvent>((event, emit) {
      emit(LoadTanksEditingState());
    });
    on<GetEditTanksNeedsEvent>((event, emit) async {
      emit(await getTanksProducts());
    });
    on<LoadTanksDetailsEvent>((event, emit) {
      emit(LoadingTanksDetailsState());
    });
    on<GetTanksDetailsEvent>((event, emit) async {
      emit(await getTanksDetailsEvent(event));
    });
    on<LoadTanksDailyMeasurementEvent>((event, emit) {
      emit(LoadingTanksDailyMeasurementState());
    });
    on<GetTanksDailyMeasurementEvent>((event, emit) async {
      emit(await getTanksDailyMeasurementEvent(event));
    });
    on<AddTankDetailsEvent>((event, emit) async {
      emit(AddingTankDetailsState(event));
    });
    on<AddingTankDetailsEvent>((event, emit) async {
      emit(await addedTankDetailsEvent(event));
    });
    on<LoadTanksEquilibriumEvent>((event, emit) {
      emit(LoadingTanksEquilibriumState());
    });
    on<GetTanksEquilibriumEvent>((event, emit) async {
      emit(await getTanksEquilibriumEvent(event));
    });

    on<ProvideProductsEditingNeedsEvent>((event, emit) {
      emit(LoadingProductsEditingNeedsState());
    });
    on<LoadProductsEditNeedsEvent>((event, emit) async {
      emit(await getProductsCategories());
    });
    on<SaveNewProductDetailsEvent>((event, emit) async {
      emit(SavingNewProductDetailsState(event));
    });
    on<AddNewProductDetailsEvent>((event, emit) async {
      emit(await addedProductDetailsEvent(event));
    });
    on<ShowProductsEvent>((event, emit) {
      emit(LoadingProductsState());
    });
    on<LoadProductsEvent>((event, emit) async {
      emit(await getProductsEvnet(event));
    });
    on<ShowProductsCommissionEvent>((event, emit) async {
      emit(LoadingProductsCommissionState());
    });
    on<LoadProductsCommissionEvent>((event, emit) async {
      emit(await getProductsCommissionEvnet(event));
    });
    on<ShowProductsPricesEvent>((event, emit) async {
      emit(LoadingProductsPricesState());
    });
    on<LoadProductsPricesEvent>((event, emit) async {
      emit(await getProductsPricesEvnet(event));
    });
  }

  Future<StationTasksState> getDailyReportEvent(
      GetDailyReportEvent event) async {
    var either = await getDailyReportUseCase
        .call(Params({"date": event.date, "station": event.station}));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (r) async => LoadedDailyReportState(dailyReport: r));
  }

  Future<StationTasksState> getDailyStationStockEvent(
      GetDailyStationStockEvent event) async {
    var either = await getDailyStationStockUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (expandedTableDataSource) async => LoadedDailyStationStockState(
            expandedTableDataSource: expandedTableDataSource));
  }

  Future<StationTasksState> getSubCompaniesListEvent(
      GetSubCompaniesListEvent event) async {
    var either = await getSubCompaniesUseCase.call(NoParams());
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (r) async => LoadedSubCompaniesState(subcompaniesList: r));
  }

  Future<StationTasksState> getMarketingCompaniesEvent(
      GetMarketingCompaniesEvent event) async {
    var either = await getMarketingCompaniesUseCase.call(NoParams());
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (r) async => LoadedMarketingCompaniesState(marketingCompaniesList: r));
  }

  Future<StationTasksState> getStationsListEvent(GetStationsEvent event) async {
    var either = await getStationsUseCase.call(NoParams());
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (r) async => LoadedStationsState(stationsList: r));
  }

  Future<StationTasksState> getStationCustomersList(
      GetStationCustomersListEvent event) async {
    var station = StationPage.of(event.context)!.station;
    var cusotmersEither =
        await getStationCustomersUseCase.call(Params(station));
    return cusotmersEither.fold<Future<StationTasksState>>(
      (l) async => ErrorState(l.message),
      (customersList) async {
        var trucksEither =
            await getCustomersTrucksUseCase.call(Params(station));
        return trucksEither.fold<Future<StationTasksState>>(
          (l) async => ErrorState(l.message),
          (trucksList) async => LoadedStationCustomersState(
              cusotmersList: customersList, cusotmersTrucksList: trucksList),
        );
      },
    );
  }

  Future<StationTasksState> getTanksDetailsEvent(
      GetTanksDetailsEvent event) async {
    var either = await getTanksDetailsUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message), (stationTanksList) async {
      Either<Failure, List<TankContentTypeEntity>> contentTypeEither =
          await getTanksContentTypeUseCase
              .call(Params(StationPage.of(event.context)!.station));
      return contentTypeEither.fold<Future<StationTasksState>>(
          (l) async => ErrorState(l.message),
          (contentTypeList) async => LoadedTanksDetailsState(
              stationTanksList: stationTanksList,
              contentTypeList: contentTypeList));
    });
  }

  Future<StationTasksState> getTanksProducts() async {
    var either = await getTanksProductsUseCase.call(NoParams());
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (products) async => LoadedTanksEditingState(products: products));
  }

  Future<StationTasksState> getTanksDailyMeasurementEvent(
      GetTanksDailyMeasurementEvent event) async {
    var either = await getTanksDailyMeasuermentsUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (expandedTableDataSource) async => LoadedTanksDailyMeasurementState(
            expandedTableDataSource: expandedTableDataSource));
  }

  Future<StationTasksState> getTanksEquilibriumEvent(
      GetTanksEquilibriumEvent event) async {
    var either = await getTanksEquilibriumUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (expandedTableDataSource) async => LoadedTanksEquilibriumState(
            expandedTableDataSource: expandedTableDataSource));
  }

  Future<StationTasksState> addedTankDetailsEvent(
      AddingTankDetailsEvent event) async {
    var either = await addTankDetailseUseCase.call(Params({
      TankTablable.NAME: event.event.tankName,
      TankTablable.STATION_NAME: event.event.stationName,
      TankTablable.CAPACITY: event.event.tankCapacity,
      TankContentTypeTablable.DATE: event.event.date,
      TankContentTypeTablable.PRODUCT_NAME: event.event.tankProduct,
    }));
    return either.fold((l) async => ErrorState(l.message),
        (r) async => await getTanksProducts());
  }

  Future<StationTasksState> getProductsCategories() async {
    var either = await getProductsCategoriesUseCase.call(NoParams());
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (categories) async =>
            LoadedProductsEditingNeedsState(productsCategories: categories));
  }

  Future<StationTasksState> getProductsEvnet(LoadProductsEvent event) async {
    var either = await getProductsUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (productsDetails) async => LoadedProductsState(
              productsEither:
                  productsDetails[GetProductsUseCase.PRODUCTS_EITHER]
                      as Either<Failure, List<ProductEntity>>,
              categoriesEither:
                  productsDetails[GetProductsUseCase.PRODUCTS_CATEGORY_EITHER]
                      as Either<Failure, List<ProductsCategoryEnitity>>,
            ));
  }

  Future<StationTasksState> addedProductDetailsEvent(
      AddNewProductDetailsEvent event) async {
    var either =
        await addProductDetailsUseCase.call(Params(EditingProductDetailsDto(
      productName: event.event.productName,
      categoryName: event.event.category,
      date: event.event.date,
      productPurchasePrice: event.event.purchasePrice,
      productSalePrice: event.event.salePrice,
    )));
    return either.fold((l) async => ErrorState(l.message),
        (r) async => await getProductsCategories());
  }

  Future<StationTasksState> getProductsCommissionEvnet(
      LoadProductsCommissionEvent event) async {
    var either = await getProductsCommissionUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
        (l) async => ErrorState(l.message),
        (products) async =>
            LoadedProductsCommissionState(productsCommissionList: products));
  }

  Future<StationTasksState> getProductsPricesEvnet(
      LoadProductsPricesEvent event) async {
    var either = await getProductsPricesUseCase
        .call(Params(StationPage.of(event.context)!.station));
    return either.fold<Future<StationTasksState>>(
      (l) async => ErrorState(l.message),
      (productsPrices) async => LoadedProductsPricesState(
          productsPurchasePriceEither:
              productsPrices[GetProductsPricesUseCase.PURCHASE_PRICES_EITHER]
                  as Either<Failure, List<ProductPurchasePriceEnitity>>,
          productsSalePriceEither:
              productsPrices[GetProductsPricesUseCase.SALES_PRICES_EITHER]
                  as Either<Failure, List<ProductSalePriceEnitity>>),
    );
  }
}

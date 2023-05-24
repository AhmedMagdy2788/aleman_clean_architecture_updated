part of 'station_tasks_bloc.dart';

abstract class StationTasksState extends Equatable {
  const StationTasksState();

  @override
  List<Object> get props => [];
  Widget buildBodyPage(BuildContext context);
}

class StationTasksInitial extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class ErrorState extends StationTasksState {
  final String message;

  const ErrorState(this.message);

  @override
  Widget buildBodyPage(BuildContext context) {
    return MessageDisplayWidget(message: message);
  }
}

//* Dashboard states
class ShowDailyReportState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class ShowDashboardState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class LoadingDashboardState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

//* Daily Report states
class LoadingDailyReportState extends StationTasksState {
  final ShowDailyReportPageEvent event;
  const LoadingDailyReportState(this.event);
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context).add(GetDailyReportEvent(
      context,
      date: event.reportDate,
      station: event.station,
    ));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedDailyReportState extends StationTasksState {
  final DailyReport? dailyReport;
  const LoadedDailyReportState({required this.dailyReport});
  @override
  Widget buildBodyPage(BuildContext context) {
    return DailyReportPage(
      dailyReport: dailyReport,
    );
  }
}

class LoadingDailyStationStockState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetDailyStationStockEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedDailyStationStockState extends StationTasksState {
  final ExpandedTableDataSource expandedTableDataSource;
  const LoadedDailyStationStockState({required this.expandedTableDataSource});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SingleExpandedPaginatedTableWidget(
      table: expandedTableDataSource,
    );
  }

  @override
  List<Object> get props => [
        expandedTableDataSource.dataList,
        expandedTableDataSource.columns,
        expandedTableDataSource.title
      ];
}

//* MarketingCompnies states
class ShowMarketingCompaniesState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class LoadingMarketingCompaniesState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetMarketingCompaniesEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedMarketingCompaniesState extends StationTasksState {
  final List<MarketingComapnyEntity> marketingCompaniesList;
  const LoadedMarketingCompaniesState({required this.marketingCompaniesList});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SinglePaginatedTablePage<MarketingComapnyEntity>(
        tableData: MarketingComapnyTableDataSouce(marketingCompaniesList));
  }
}

//* Subcomapnies states
class LoadingSubCompaniesState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetSubCompaniesListEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedSubCompaniesState extends StationTasksState {
  final List<SubCompanyEntity> subcompaniesList;
  const LoadedSubCompaniesState({required this.subcompaniesList});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SinglePaginatedTablePage<SubCompanyEntity>(
        tableData: SubCompanyTableDataSouce(subcompaniesList));
  }

  @override
  List<Object> get props => subcompaniesList;
}

//*customers states
class LoadingAddCustomerState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class ShowAddCustomerState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class LoadingStationCustomersState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetStationCustomersListEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedStationCustomersState extends StationTasksState {
  final List<CustomerEntity> cusotmersList;
  final List<CustomerTruckEntity> cusotmersTrucksList;
  const LoadedStationCustomersState(
      {required this.cusotmersTrucksList, required this.cusotmersList});
  @override
  Widget buildBodyPage(BuildContext context) {
    return CorrelatedPaginatedTables<CustomerEntity, CustomerTruckEntity>(
      mainTableData: CustomerTableDataSouce(cusotmersList),
      relatedTableData: CustomerTruckTableDataSouce(cusotmersTrucksList),
    );
  }

  @override
  List<Object> get props => cusotmersList;
}

//* Stations states
class LoadedStationsState extends StationTasksState {
  final List<StationEntity> stationsList;
  const LoadedStationsState({required this.stationsList});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SinglePaginatedTablePage<StationEntity>(
        tableData: StationTableDataSouce(stationsList));
  }
}

class LoadingStationsState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context).add(GetStationsEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

//* Products states
class LoadingProductsEditingNeedsState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(LoadProductsEditNeedsEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedProductsEditingNeedsState extends StationTasksState {
  final List<String> productsCategories;
  const LoadedProductsEditingNeedsState({required this.productsCategories});
  @override
  Widget buildBodyPage(BuildContext context) {
    return AddProductsDetailsPage(productsCategories: productsCategories);
  }
}

class LoadingProductsState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context).add(LoadProductsEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedProductsState extends StationTasksState {
  final Either<Failure, List<ProductsCategoryEnitity>> categoriesEither;
  final Either<Failure, List<ProductEntity>> productsEither;
  const LoadedProductsState(
      {required this.categoriesEither, required this.productsEither});
  @override
  Widget buildBodyPage(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          productsEither.fold<Widget>(
              (l) => MessageDisplayWidget(message: l.message),
              (productsList) => SinglePaginatedTablePage<ProductEntity>(
                  tableData: ProductTableDataSouce(productsList))),
          categoriesEither.fold<Widget>(
              (l) => MessageDisplayWidget(message: l.message),
              (productsCategoriesList) =>
                  SinglePaginatedTablePage<ProductsCategoryEnitity>(
                      tableData: ProductsCategoryTableDataSouce(
                          productsCategoriesList))),
        ],
      ),
    );
  }
}

class SavingNewProductDetailsState extends StationTasksState {
  final SaveNewProductDetailsEvent event;

  const SavingNewProductDetailsState(this.event);
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(AddNewProductDetailsEvent(context, event));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadingProductsCommissionState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(LoadProductsCommissionEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedProductsCommissionState extends StationTasksState {
  final List<ProductCommissionEnitity> productsCommissionList;
  const LoadedProductsCommissionState({required this.productsCommissionList});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SinglePaginatedTablePage<ProductCommissionEnitity>(
        tableData: ProductCommissionTableDataSouce(productsCommissionList));
  }
}

class LoadingProductsPricesState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(LoadProductsPricesEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedProductsPricesState extends StationTasksState {
  final Either<Failure, List<ProductPurchasePriceEnitity>>
      productsPurchasePriceEither;
  final Either<Failure, List<ProductSalePriceEnitity>> productsSalePriceEither;
  const LoadedProductsPricesState(
      {required this.productsPurchasePriceEither,
      required this.productsSalePriceEither});
  @override
  Widget buildBodyPage(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          productsPurchasePriceEither.fold<Widget>(
              (l) => MessageDisplayWidget(message: l.message),
              (productsPurchasePriceList) =>
                  SinglePaginatedTablePage<ProductPurchasePriceEnitity>(
                      tableData: ProductPurchasePriceTableDataSouce(
                          productsPurchasePriceList))),
          productsSalePriceEither.fold<Widget>(
              (l) => MessageDisplayWidget(message: l.message),
              (productsSalePriceList) =>
                  SinglePaginatedTablePage<ProductSalePriceEnitity>(
                      tableData: ProductSalePriceTableDataSouce(
                          productsSalePriceList)))
        ],
      ),
    );
  }
}

//* Tanks states
class ShowTanksDetailsState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class ShowTanksDailyMeasurementState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class ShowTanksEquilibriumState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    return const DashboardPage();
  }
}

class LoadedTanksDetailsState extends StationTasksState {
  final List<TankEntity> stationTanksList;
  final List<TankContentTypeEntity> contentTypeList;
  const LoadedTanksDetailsState({
    required this.stationTanksList,
    required this.contentTypeList,
  });
  @override
  Widget buildBodyPage(BuildContext context) {
    return CorrelatedPaginatedTables<TankEntity, TankContentTypeEntity>(
      mainTableData: TankTableDataSouce(stationTanksList),
      relatedTableData: TankContentTypeTableDataSouce(contentTypeList),
    );
  }

  @override
  List<TankEntity> get props => stationTanksList;
}

class LoadingTanksDailyMeasurementState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetTanksDailyMeasurementEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedTanksDailyMeasurementState extends StationTasksState {
  final ExpandedTableDataSource expandedTableDataSource;
  const LoadedTanksDailyMeasurementState(
      {required this.expandedTableDataSource});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SingleExpandedPaginatedTableWidget(
      table: expandedTableDataSource,
    );
  }

  @override
  List<Object> get props => [
        expandedTableDataSource.dataList,
        expandedTableDataSource.columns,
        expandedTableDataSource.title
      ];
}

class LoadingTanksEquilibriumState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetTanksEquilibriumEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedTanksEquilibriumState extends StationTasksState {
  final ExpandedTableDataSource expandedTableDataSource;
  const LoadedTanksEquilibriumState({required this.expandedTableDataSource});
  @override
  Widget buildBodyPage(BuildContext context) {
    return SingleExpandedPaginatedTableWidget(
      table: expandedTableDataSource,
    );
  }

  @override
  List<Object> get props => [
        expandedTableDataSource.dataList,
        expandedTableDataSource.columns,
        expandedTableDataSource.title
      ];
}

class LoadTanksEditingState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetEditTanksNeedsEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadedTanksEditingState extends StationTasksState {
  final List<String> products;
  const LoadedTanksEditingState({required this.products});
  @override
  Widget buildBodyPage(BuildContext context) {
    return AddTanksDetailsPage(tanksProducts: products);
    // return AddEntityFormPage<TankContentTypeEntity>(
    //   tableDataSource: TankContentTypeTableDataSouce([]),
    // );
  }
}

class LoadingTanksDetailsState extends StationTasksState {
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(GetTanksDetailsEvent(context));
    return const Center(child: CircularProgressIndicator());
  }
}

class AddingTankDetailsState extends StationTasksState {
  final AddTankDetailsEvent event;

  const AddingTankDetailsState(this.event);
  @override
  Widget buildBodyPage(BuildContext context) {
    BlocProvider.of<StationTasksBloc>(context)
        .add(AddingTankDetailsEvent(context, event));
    return const Center(child: CircularProgressIndicator());
  }
}

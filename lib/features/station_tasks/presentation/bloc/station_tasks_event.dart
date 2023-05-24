part of 'station_tasks_bloc.dart';

abstract class StationTasksEvent extends Equatable {
  final BuildContext context;
  const StationTasksEvent(this.context);

  @override
  List<Object> get props => [];
}

//* Dashboard Events
class ShowDashboardEvent extends StationTasksEvent {
  const ShowDashboardEvent(super.context);
}

class LoadedDashboardEvent extends StationTasksEvent {
  const LoadedDashboardEvent(super.context);
}

//* Daily Report Event
class ShowDailyReportPageEvent extends StationTasksEvent {
  final DateTime reportDate;
  final StationEntity station;
  const ShowDailyReportPageEvent(
    super.context, {
    required this.reportDate,
    required this.station,
  });
}

class GetDailyReportEvent extends StationTasksEvent {
  final DateTime date;
  final StationEntity station;
  const GetDailyReportEvent(
    super.context, {
    required this.date,
    required this.station,
  });
}

class LoadedDailyReportEvent extends StationTasksEvent {
  const LoadedDailyReportEvent(super.context);
}

class GetDailyStationStockEvent extends StationTasksEvent {
  const GetDailyStationStockEvent(super.context);
}

class LoadDailyStationStockEvent extends StationTasksEvent {
  const LoadDailyStationStockEvent(super.context);
}

class LoadedDailyStationStockEvent extends StationTasksEvent {
  const LoadedDailyStationStockEvent(super.context);
}

//* Stations Events
class GetStationsEvent extends StationTasksEvent {
  const GetStationsEvent(super.context);
}

class LoadedStationsEvent extends StationTasksEvent {
  const LoadedStationsEvent(super.context);
}

class LoadStationsEvent extends StationTasksEvent {
  const LoadStationsEvent(super.context);
}

//* Customers Events
class LoadedAddCustomerEvent extends StationTasksEvent {
  const LoadedAddCustomerEvent(super.context);
}

class LoadStationCustomersEvent extends StationTasksEvent {
  const LoadStationCustomersEvent(super.context);
}

class LoadedStationCustomersEvent extends StationTasksEvent {
  const LoadedStationCustomersEvent(super.context);
}

class LoadAddCustomerEvent extends StationTasksEvent {
  const LoadAddCustomerEvent(super.context);
}

class GetStationCustomersListEvent extends StationTasksEvent {
  const GetStationCustomersListEvent(super.context);
}

//* Subcompanies Events
class LoadedSubCompaniesEvent extends StationTasksEvent {
  const LoadedSubCompaniesEvent(super.context);
}

class LoadSubCompaniesEvent extends StationTasksEvent {
  const LoadSubCompaniesEvent(super.context);
}

class GetSubCompaniesListEvent extends StationTasksEvent {
  const GetSubCompaniesListEvent(super.context);
}

//* Marketing Companies Evnets
class LoadedMarketingCompaniesEvent extends StationTasksEvent {
  const LoadedMarketingCompaniesEvent(super.context);
}

class LoadMarketingCompaniesEvent extends StationTasksEvent {
  const LoadMarketingCompaniesEvent(super.context);
}

class GetMarketingCompaniesEvent extends StationTasksEvent {
  const GetMarketingCompaniesEvent(super.context);
}

//* Tanks Events
class LoadTanksDetailsEvent extends StationTasksEvent {
  const LoadTanksDetailsEvent(super.context);
}

class LoadTanksDailyMeasurementEvent extends StationTasksEvent {
  const LoadTanksDailyMeasurementEvent(super.context);
}

class LoadTanksEquilibriumEvent extends StationTasksEvent {
  const LoadTanksEquilibriumEvent(super.context);
}

class LoadTanksEditingEvent extends StationTasksEvent {
  const LoadTanksEditingEvent(super.context);
}

class GetTanksDetailsEvent extends StationTasksEvent {
  const GetTanksDetailsEvent(super.context);
}

class GetTanksDailyMeasurementEvent extends StationTasksEvent {
  const GetTanksDailyMeasurementEvent(super.context);
}

class GetTanksEquilibriumEvent extends StationTasksEvent {
  const GetTanksEquilibriumEvent(super.context);
}

class AddedTankDetailsEvent extends StationTasksEvent {
  const AddedTankDetailsEvent(super.context);
}

class LoadedTanksDetailsEvent extends StationTasksEvent {
  const LoadedTanksDetailsEvent(super.context);
}

class LoadedTanksDailyMeasurementEvent extends StationTasksEvent {
  const LoadedTanksDailyMeasurementEvent(super.context);
}

class GetEditTanksNeedsEvent extends StationTasksEvent {
  const GetEditTanksNeedsEvent(super.context);
}

class AddTankDetailsEvent extends StationTasksEvent {
  final DateTime date;
  final String stationName;
  final String tankName;
  final String tankProduct;
  final int tankCapacity;
  const AddTankDetailsEvent(
    super.context, {
    required this.date,
    required this.stationName,
    required this.tankName,
    required this.tankProduct,
    required this.tankCapacity,
  });
}

class AddingTankDetailsEvent extends StationTasksEvent {
  final AddTankDetailsEvent event;
  const AddingTankDetailsEvent(super.context, this.event);
}

class LoadedTanksEquilibriumEvent extends StationTasksEvent {
  const LoadedTanksEquilibriumEvent(super.context);
}

//* Products Events
class ProvideProductsEditingNeedsEvent extends StationTasksEvent {
  const ProvideProductsEditingNeedsEvent(super.context);
}

class LoadProductsEditNeedsEvent extends StationTasksEvent {
  const LoadProductsEditNeedsEvent(super.context);
}

class ShowProductsEvent extends StationTasksEvent {
  const ShowProductsEvent(super.context);
}

class LoadProductsEvent extends StationTasksEvent {
  const LoadProductsEvent(super.context);
}

class SaveNewProductDetailsEvent extends StationTasksEvent {
  final DateTime date;
  final String category;
  final String productName;
  final double purchasePrice;
  final double salePrice;
  const SaveNewProductDetailsEvent(
    super.context, {
    required this.date,
    required this.category,
    required this.productName,
    required this.purchasePrice,
    required this.salePrice,
  });
}

class AddNewProductDetailsEvent extends StationTasksEvent {
  final SaveNewProductDetailsEvent event;
  const AddNewProductDetailsEvent(super.context, this.event);
}

class ShowProductsCommissionEvent extends StationTasksEvent {
  const ShowProductsCommissionEvent(super.context);
}

class LoadProductsCommissionEvent extends StationTasksEvent {
  const LoadProductsCommissionEvent(super.context);
}

class ShowProductsPricesEvent extends StationTasksEvent {
  const ShowProductsPricesEvent(super.context);
}

class LoadProductsPricesEvent extends StationTasksEvent {
  const LoadProductsPricesEvent(super.context);
}

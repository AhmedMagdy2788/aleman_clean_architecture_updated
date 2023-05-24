// ignore_for_file: constant_identifier_names

import '../../../domain/entities/customer_trucks_entity.dart';
import '/core/entities/tablable_entity.dart';

class CustomerTruckTableDataSouce extends TableDataSource<CustomerTruckEntity> {
  CustomerTruckTableDataSouce(List<CustomerTruckEntity> equatableDataList)
      : super(dataList: [], title: "Customers Trucks") {
    for (var element in equatableDataList) {
      super.dataList.add(CustomerTruckTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[CustomerTruckTablable.CUSTOMER_ID] = int;
    columns[CustomerTruckTablable.CUSTOMER_NAME] = String;
    columns[CustomerTruckTablable.TRUCK_NO] = String;
    return columns;
  }
}

class CustomerTruckTablable extends TablableEntity<CustomerTruckEntity> {
  static const String CUSTOMER_ID = "Customer ID";
  static const String CUSTOMER_NAME = "Customer Name";
  static const String TRUCK_NO = "Truck No.";

  CustomerTruckTablable(CustomerTruckEntity customerTruckEntity)
      : super(customerTruckEntity);

  @override
  Map<String, dynamic> get id =>
      {CUSTOMER_ID: entity.customerId, TRUCK_NO: entity.truckNo};

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      CUSTOMER_ID: entity.customerId,
      CUSTOMER_NAME: entity.name,
      TRUCK_NO: entity.truckNo
    };
  }
}

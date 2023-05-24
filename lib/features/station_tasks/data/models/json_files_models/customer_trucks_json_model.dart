// ignore_for_file: constant_identifier_names

import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/customer_trucks_entity.dart';

class CustomerTruckJSONModel extends CustomerTruckEntity implements JSONModel {
  static const String TABLENAME = 'tblCustomersCars';
  static const String CUSTOMER_ID = "customer_id";
  static const String CUSTOMER_NAME = "customer_name";
  static const String TRUCK_NO = "truck_no";

  const CustomerTruckJSONModel(
      {required super.customerId, required super.name, required super.truckNo});

  factory CustomerTruckJSONModel.fromJson(Map<String, dynamic> json) {
    return CustomerTruckJSONModel(
      customerId: json[CUSTOMER_ID],
      name: json[CUSTOMER_NAME],
      truckNo: json[TRUCK_NO].toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {CUSTOMER_ID: customerId, CUSTOMER_NAME: name, TRUCK_NO: truckNo};
  }

  // @override
  // bool setParametersData(String parameterName, dynamic data) {
  //   switch (parameterName) {
  //     case CUSTOMER_ID:
  //       customerId = data as int;
  //       break;
  //     case CUSTOMER_NAME:
  //       name = data as String;
  //       break;
  //     case TRUCK_NO:
  //       truckNo = data as String;
  //       break;
  //     default:
  //       return false;
  //   }
  //   return true;
  // }

  // factory CustomerTruckModel.empty() {
  //   return CustomerTruckModel(customerId: -1, name: "", truckNo: "");
  // }

  // @override
  // TablableModel get empty => CustomerTruckModel.empty();
}

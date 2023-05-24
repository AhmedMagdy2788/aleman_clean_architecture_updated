// ignore_for_file: constant_identifier_names

import '../../../../../core/models/server_model.dart';
import '../../../domain/entities/customer_entity.dart';

class CustomerServerModel extends CustomerEntity implements ServerModel {
  static const String ENDPOINT = 'Customers';
  static const String ID = "id";
  static const String NAME = "name";
  static const String ADDRESS = "address";
  static const String PHONE = "phone";
  static const String GUARANTOR = "guarantor";

  const CustomerServerModel({
    required super.id,
    required super.name,
    super.address,
    super.phone,
    super.guarantor,
  });

  factory CustomerServerModel.fromJson(Map<String, dynamic> json) {
    return CustomerServerModel(
        id: json[ID],
        name: json[NAME],
        address: json[ADDRESS],
        phone: int.parse(json[PHONE]),
        guarantor: json[GUARANTOR]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NAME: name,
      ADDRESS: address,
      PHONE: phone,
      GUARANTOR: guarantor,
    };
  }
}

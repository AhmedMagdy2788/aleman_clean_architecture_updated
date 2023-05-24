// ignore_for_file: constant_identifier_names

import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/customer_entity.dart';

class CustomerJSONModel extends CustomerEntity implements JSONModel {
  static const String TABLENAME = 'tblcustomers';
  static const String ID = "id";
  static const String NAME = "name";
  static const String ADDRESS = "address";
  static const String PHONE = "phone";
  static const String GUARANTOR = "guarantor";

  const CustomerJSONModel({
    required super.id,
    required super.name,
    super.address,
    super.phone,
    super.guarantor,
  });

  factory CustomerJSONModel.fromJson(Map<String, dynamic> json) {
    return CustomerJSONModel(
        id: json[ID],
        name: json[NAME],
        address: json[ADDRESS],
        phone: json[PHONE],
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

// ignore_for_file: constant_identifier_names

import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/subcompany_entity.dart';

//testJosn.json
class SubCompanyJSONModel extends SubCompanyEntity implements JSONModel {
  static const String TABLENAME = 'Tblsubcompanies';
  static const String NAME = "subcompany_name";
  static const String ADDRESS = "address";
  static const String TAX_CARD = "tax_card";
  static const String COMMERCIAL_REGISTRATION = "commercial_registration";
  static const String FAX = "fax";
  static const String EMAIL = "email";

  const SubCompanyJSONModel({
    required super.name,
    required super.address,
    required super.taxCard,
    required super.commercialRegistration,
    super.fax,
    super.email,
  });

  factory SubCompanyJSONModel.fromJson(Map<String, dynamic> json) {
    return SubCompanyJSONModel(
        name: json[NAME],
        address: json[ADDRESS],
        taxCard: json[TAX_CARD],
        commercialRegistration: json[COMMERCIAL_REGISTRATION],
        fax: json[FAX],
        email: json[EMAIL]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      NAME: name,
      ADDRESS: address,
      TAX_CARD: taxCard,
      COMMERCIAL_REGISTRATION: commercialRegistration,
      FAX: fax,
      EMAIL: email,
    };
  }

  // @override
  // bool setParametersData(String parameterName, dynamic data) {
  //   switch (parameterName) {
  //     case NAME:
  //       name = data as String;
  //       break;
  //     case ADDRESS:
  //       address = data as String;
  //       break;
  //     case TAX_CARD:
  //       taxCard = data as String;
  //       break;
  //     case COMMERCIAL_REGISTRATION:
  //       commercialRegistration = data as String;
  //       break;
  //     case FAX:
  //       fax = data as String;
  //       break;
  //     case EMAIL:
  //       email = data as String;
  //       break;
  //     default:
  //       return false;
  //   }
  //   return true;
  // }

  // factory SubCompanyModel.empty() {
  //   return const SubCompanyModel(
  //       name: "", address: "", taxCard: "", commercialRegistration: "");
  // }

  // @override
  // TablableModel get empty => SubCompanyModel.empty();
}

class CompanyDriverJSONModel extends CompanyDriverEntity implements JSONModel {
  static const String TABLENAME = 'tblCompanyDrivers';
  static const String ID = "company_driver_id";
  static const String DRIVER_NAME = "driver_name";
  static const String LICENSE_NO = "license_no";

  const CompanyDriverJSONModel({
    required super.id,
    required super.driverName,
    required super.licenseNo,
  });

  factory CompanyDriverJSONModel.fromJson(Map<String, dynamic> json) {
    return CompanyDriverJSONModel(
      id: json[ID],
      driverName: json[DRIVER_NAME],
      licenseNo: json[LICENSE_NO],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      DRIVER_NAME: driverName,
      LICENSE_NO: licenseNo,
    };
  }
}

class CompanyTruckJSONModel extends CompanyTruckEntity implements JSONModel {
  static const String TABLENAME = 'tblCompanyTrucks';
  static const String ID = "id";
  static const String COMPANY_TRUCK_NO = "company_truck_no";
  static const String MODEL = "model";
  static const String TRUCK_LOAD = "truck_load";

  const CompanyTruckJSONModel({
    required super.id,
    required super.companyTruckNo,
    required super.model,
    super.truckLoad,
  });

  factory CompanyTruckJSONModel.fromJson(Map<String, dynamic> json) {
    return CompanyTruckJSONModel(
      id: json[ID],
      companyTruckNo: json[COMPANY_TRUCK_NO],
      model: json[MODEL],
      truckLoad: json[TRUCK_LOAD],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      COMPANY_TRUCK_NO: companyTruckNo,
      MODEL: model,
      TRUCK_LOAD: truckLoad,
    };
  }
}

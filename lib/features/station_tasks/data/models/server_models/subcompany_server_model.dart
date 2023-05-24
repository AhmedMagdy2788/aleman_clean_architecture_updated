// ignore_for_file: constant_identifier_names

import '../../../../../core/models/server_model.dart';
import '../../../domain/entities/subcompany_entity.dart';

//testJosn.json
class SubCompanyServerModel extends SubCompanyEntity implements ServerModel {
  static const String ENDPOINT = 'Subcompanies';
  static const String NAME = "subcompany_name";
  static const String ADDRESS = "address";
  static const String TAX_CARD = "tax_card";
  static const String COMMERCIAL_REGISTRATION = "commercial_registration";
  static const String FAX = "fax";
  static const String EMAIL = "email";

  const SubCompanyServerModel({
    required super.name,
    required super.address,
    required super.taxCard,
    required super.commercialRegistration,
    super.fax,
    super.email,
  });

  factory SubCompanyServerModel.fromJson(Map<String, dynamic> json) {
    return SubCompanyServerModel(
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

class CompanyDriverServerModel extends CompanyDriverEntity
    implements ServerModel {
  static const String ENDPOINT = 'CompanyDrivers';
  static const String ID = "id";
  static const String DRIVER_NAME = "driver_name";
  static const String LICENSE_NO = "license_no";

  const CompanyDriverServerModel({
    required super.id,
    required super.driverName,
    required super.licenseNo,
  });

  factory CompanyDriverServerModel.fromJson(Map<String, dynamic> json) {
    return CompanyDriverServerModel(
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

class CompanyTruckServerModel extends CompanyTruckEntity
    implements ServerModel {
  static const String ENDPOINT = 'CompanyTrucks';
  static const String ID = "id";
  static const String COMPANY_TRUCK_NO = "company_truck_no";
  static const String MODEL = "model";
  static const String TRUCK_LOAD = "truck_load";

  const CompanyTruckServerModel({
    required super.id,
    required super.companyTruckNo,
    required super.model,
    required super.truckLoad,
  });

  factory CompanyTruckServerModel.fromJson(Map<String, dynamic> json) {
    return CompanyTruckServerModel(
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

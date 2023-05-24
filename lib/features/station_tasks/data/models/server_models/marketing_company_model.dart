// ignore_for_file: constant_identifier_names
import '../../../../../core/models/server_model.dart';
import '../../../domain/entities/marketing_company_entity.dart';

//testJosn.json
class MarketingComapnyServerModel extends MarketingComapnyEntity
    implements ServerModel {
  static const String ENDPOINT = 'MarketingCompanies';
  static const String NAME = "marketing_comany";
  static const String ADDRESS = "address";
  static const String PHONE = "phone";
  static const String EMAIL = "email";
  static const String FAX = "fax";

  const MarketingComapnyServerModel({
    required super.name,
    super.address,
    super.phone,
    super.email,
    super.fax,
  });

  factory MarketingComapnyServerModel.fromJson(Map<String, dynamic> json) {
    return MarketingComapnyServerModel(
      name: json[NAME],
      address: json[ADDRESS],
      phone: json[PHONE],
      email: json[EMAIL],
      fax: json[FAX],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      NAME: name,
      ADDRESS: address,
      PHONE: phone,
      EMAIL: email,
      FAX: fax,
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
  //     case PHONE:
  //       phone = data as String;
  //       break;
  //     case EMAIL:
  //       email = data as String;
  //       break;
  //     case FAX:
  //       fax = data as String;
  //       break;
  //     default:
  //       return false;
  //   }
  //   return true;
  // }

  // MarketingComapnyModel.empty() {
  //   name = "";
  //   address = null;
  //   phone = null;
  //   email = null;
  //   fax = null;
  // }

  // @override
  // TablableModel get empty => MarketingComapnyModel.empty();
}

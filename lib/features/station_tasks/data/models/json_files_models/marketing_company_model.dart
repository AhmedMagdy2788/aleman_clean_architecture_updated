// ignore_for_file: constant_identifier_names
import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/marketing_company_entity.dart';

//testJosn.json
class MarketingComapnyJSONModel extends MarketingComapnyEntity
    implements JSONModel {
  static const String TABLENAME = 'tblMarketingCompnies';
  static const String NAME = "marketing_company";
  static const String ADDRESS = "address";
  static const String PHONE = "phone";
  static const String EMAIL = "email";
  static const String FAX = "fax";

  const MarketingComapnyJSONModel({
    required super.name,
    super.address,
    super.phone,
    super.email,
    super.fax,
  });

  factory MarketingComapnyJSONModel.fromJson(Map<String, dynamic> json) {
    return MarketingComapnyJSONModel(
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

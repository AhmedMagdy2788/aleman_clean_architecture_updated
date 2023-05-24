// ignore_for_file: constant_identifier_names

import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/station_entity.dart';

class StationJSONModel extends StationEntity implements JSONModel {
  static const String TABLENAME = 'tblStations';
  static const String ID = "station_id";
  static const String NAME = "station_name";
  static const String OWNER_COMPANY = "owner_company";
  static const String LOCATION = "location";
  static const String PARTNER = "partner_ship";

  const StationJSONModel({
    required super.id,
    required super.name,
    required super.ownerCompany,
    required super.location,
    super.partner,
  });

  factory StationJSONModel.fromJson(Map<String, dynamic> json) {
    return StationJSONModel(
        id: json[ID],
        name: json[NAME],
        ownerCompany: json[OWNER_COMPANY],
        location: json[LOCATION],
        partner: json[PARTNER]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NAME: name,
      OWNER_COMPANY: ownerCompany,
      LOCATION: location,
      PARTNER: partner,
    };
  }

  // @override
  // bool setParametersData(String parameterName, dynamic data) {
  //   switch (parameterName) {
  //     case ID:
  //       id = data as int;
  //       break;
  //     case NAME:
  //       name = data as String;
  //       break;
  //     case OWNER_COMPANY:
  //       ownerCompany = data as String;
  //       break;
  //     case LOCATION:
  //       location = data as String;
  //       break;
  //     case PARTNER:
  //       partner = data as String;
  //       break;
  //     default:
  //       return false;
  //   }
  //   return true;
  // }

  // factory StationModel.empty() {
  //   return const StationModel(
  //       id: -1, name: "", ownerCompany: "", location: "", partner: "");
  // }

  // @override
  // TablableModel get empty => StationModel.empty();
}

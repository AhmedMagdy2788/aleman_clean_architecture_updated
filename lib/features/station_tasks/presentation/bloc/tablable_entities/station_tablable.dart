// ignore_for_file: constant_identifier_names

import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/station_entity.dart';

class StationTableDataSouce extends TableDataSource<StationEntity> {
  StationTableDataSouce(List<StationEntity> equatableDataList)
      : super(dataList: [], title: "Stations") {
    for (var element in equatableDataList) {
      super.dataList.add(StationTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[StationTablable.ID] = int;
    columns[StationTablable.NAME] = String;
    columns[StationTablable.OWNER_COMPANY] = String;
    columns[StationTablable.LOCATION] = int;
    columns[StationTablable.PARTNER] = String;
    return columns;
  }
}

class StationTablable extends TablableEntity<StationEntity> {
  static const String ID = "id";
  static const String NAME = "Station Name";
  static const String OWNER_COMPANY = "Owner Company";
  static const String LOCATION = "Location";
  static const String PARTNER = "Partner Ship";

  StationTablable(StationEntity stationEntity) : super(stationEntity);
  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: entity.id,
      NAME: entity.name,
      OWNER_COMPANY: entity.ownerCompany,
      LOCATION: entity.location,
      PARTNER: entity.partner,
    };
  }

  @override
  get id => entity.id;
}

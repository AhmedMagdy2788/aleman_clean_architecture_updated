import '../../../../../core/entities/expanded_row_entity.dart';
import '../../../domain/entities/station_entity.dart';

class StationDetails {
  StationEntity station;
  Map<int, String>? tanks;
  StationDetails({required this.station, this.tanks});
}

class DailyReport {
  DateTime currentDate;
  StationDetails stationDetails;
  DailyReport({required this.stationDetails, required this.currentDate});
  late DateTime prevDate;
  //* Tanks measurments *//
  late ExpandedRowEntity prevTanksProductType;
  late ExpandedRowEntity currentTanksProductType;
  late ExpandedRowEntity prevTanksMeasurments;
  late ExpandedRowEntity currentTanksMeasurments;
  late ExpandedRowEntity prevCountersReadings;
  late ExpandedRowEntity currentCountersReadings;
  //* Pumps and Counters *//
}

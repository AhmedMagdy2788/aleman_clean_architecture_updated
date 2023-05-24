import 'package:flutter/material.dart';

import '../../bloc/tablable_entities/station_details.dart';

class PumpsCountersDailyTableWidget extends StatelessWidget {
  final DailyReport dailyReport;
  const PumpsCountersDailyTableWidget({super.key, required this.dailyReport});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevRowData = dailyReport.prevCountersReadings.rowData;
    Map<String, dynamic> curretnRowData =
        dailyReport.currentCountersReadings.rowData;
    // prevRowData.remove(TanksDailyMeasurementTablable.DATE);
    // curretnRowData.remove(TanksDailyMeasurementTablable.DATE);

    List<DataColumn> dataColumnsList = [];
    List<String> columnsString = [];
    List<DataCell> currentRowDatacells = [];
    List<DataCell> prevRowDatacells = [];
    List<DataCell> tanksMeasurementsDifferences = [];

    curretnRowData.forEach((key, value) {
      columnsString.add(key);
      dataColumnsList.add(DataColumn(
          label: Text(key, style: Theme.of(context).textTheme.headlineSmall)));
    });
    return Container();
  }
}

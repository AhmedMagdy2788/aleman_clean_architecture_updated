import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../bloc/tablable_entities/station_details.dart';
import '../../bloc/tablable_entities/tanks_pumps_counters_tablable.dart';

class TanksMeasurementsTableWidget extends StatelessWidget {
  final DailyReport dailyReport;
  const TanksMeasurementsTableWidget({required this.dailyReport, super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> prevRowData = dailyReport.prevTanksMeasurments.rowData;
    Map<String, dynamic> curretnRowData =
        dailyReport.currentTanksMeasurments.rowData;
    Map<String, dynamic> prevTankProductData =
        dailyReport.prevTanksProductType.rowData;
    Map<String, dynamic> curretnTankProductData =
        dailyReport.currentTanksProductType.rowData;
    prevRowData.remove(TanksDailyMeasurementTablable.DATE);
    curretnRowData.remove(TanksDailyMeasurementTablable.DATE);
    prevTankProductData.remove(TankContentTypeTablable.DATE);
    curretnTankProductData.remove(TankContentTypeTablable.DATE);

    log("previous: ${prevRowData.toString()}");
    log("current: ${curretnRowData.toString()}");
    log("previous tank products: ${prevTankProductData.toString()}");
    log("current tank products: ${curretnTankProductData.toString()}");

    List<DataColumn> dataColumnsList = [];
    List<String> columnsString = [];
    List<DataCell> currentRowDatacells = [];
    List<DataCell> prevRowDatacells = [];
    List<DataCell> currentTankProductDatacells = [];
    List<DataCell> prevTankProductDatacells = [];
    List<DataCell> tanksMeasurementsDifferences = [];

    curretnRowData.forEach((key, value) {
      columnsString.any((element) => element == key)
          ? null
          : columnsString.add(key);
      String currentDataValue =
          NumberFormat("#,###.0#").format(curretnRowData[key]);
      currentRowDatacells
          .add(DataCell(buildRowCell(context, currentDataValue)));
      currentTankProductDatacells
          .add(DataCell(buildRowCell(context, curretnTankProductData[key])));
    });

    prevRowData.forEach((key, value) {
      columnsString.any((element) => element == key)
          ? null
          : columnsString.add(key);
      String prevDataValue = NumberFormat("#,###.0#").format(prevRowData[key]);
      prevRowDatacells.add(DataCell(buildRowCell(context, prevDataValue)));
      prevTankProductDatacells
          .add(DataCell(buildRowCell(context, prevTankProductData[key])));
    });

    for (var key in columnsString) {
      dataColumnsList.add(DataColumn(
          label: Text(key, style: Theme.of(context).textTheme.headlineSmall)));
      String differnces = NumberFormat("#,###.0#")
          .format(curretnRowData[key] - prevRowData[key]);
      tanksMeasurementsDifferences
          .add(DataCell(buildRowCell(context, differnces)));
    }

    columnsString.insert(0, "Tanks Measurements");
    dataColumnsList.insert(
        0, DataColumn(label: buildRowHeader(context, "Tanks Measurements")));
    currentTankProductDatacells.insert(
        0,
        DataCell(
          buildRowHeader(context, "Current Date Product"),
        ));
    currentRowDatacells.insert(
        0,
        DataCell(
          buildRowHeader(context, "current Date Measurements"),
        ));
    prevTankProductDatacells.insert(
        0,
        DataCell(
          buildRowHeader(context, "previous Date Product"),
        ));
    prevRowDatacells.insert(
        0,
        DataCell(
          buildRowHeader(context, "previous Date Measurements"),
        ));
    tanksMeasurementsDifferences.insert(
        0,
        DataCell(
          buildRowHeader(context, "Measurements Differences"),
        ));
    return DataTable(
      columns: dataColumnsList,
      rows: [
        DataRow(
            cells: currentTankProductDatacells,
            color: MaterialStateProperty.all(Colors.blueGrey[800])),
        DataRow(
            cells: currentRowDatacells,
            color: MaterialStateProperty.all(Colors.blueGrey[300])),
        DataRow(
            cells: prevTankProductDatacells,
            color: MaterialStateProperty.all(Colors.blueGrey[800])),
        DataRow(
            cells: prevRowDatacells,
            color: MaterialStateProperty.all(Colors.blueGrey[300])),
        DataRow(
            cells: tanksMeasurementsDifferences,
            color: MaterialStateProperty.all(Colors.blueGrey[600])),
      ],
      headingRowColor: MaterialStateProperty.all(Colors.blueGrey[900]),
      dataRowHeight: 75,
      horizontalMargin: 0,
    );
  }

  Widget buildRowHeader(BuildContext context, String label) {
    return Container(
      width: 230,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: Colors.blueGrey[900],
      child: Text(label, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  Widget buildRowCell(BuildContext context, String label) {
    return SelectableText(
      label,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          shadows: [
            const Shadow(
                color: Colors.black45, offset: Offset(5, 5), blurRadius: 16)
          ]),
    );
  }
}

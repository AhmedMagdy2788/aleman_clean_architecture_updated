import 'dart:io' as io;
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../../core/models/expanded_row_model.dart';
import '../../../../core/models/json_model.dart';
import '../models/json_files_models/tank_json_model.dart';

enum JsonInitState { notInit, pathNOtExist, fullyInit }

abstract class RawTableJsonDataSource {
  Future<List<TablableModel>> getRawTableRows<TablableModel>(String tableName,
      TablableModel Function(Map<String, dynamic>) createObject,
      [bool Function(TablableModel)? filterFunction]);
  Future<bool> addRowToRawTable(String tableName, JSONModel object,
      bool Function(JSONModel)? validationFunciton);
  Future<void> updateRowToRawTable(String tableName, dynamic id, JSONModel row);
  Future<void> deleteRowToRawTable(String tableName, dynamic id);
  Future<void> updateJsonSource(String tableName, List<JSONModel> rows);
}

class RawTableJsonDataSourceImpl implements RawTableJsonDataSource {
  String directory;
  List files = [];
  RawTableJsonDataSourceImpl({required this.directory});

  @override
  Future<List<T>> getRawTableRows<T>(
      String tableName, T Function(Map<String, dynamic>) createObject,
      [bool Function(T)? filterFunction]) async {
    String fileName = tableName;
    try {
      final String response =
          await rootBundle.loadString('$directory/$fileName.json');
      final List<dynamic> fileData = await json.decode(response);
      if (filterFunction == null) {
        return fileData.map((e) => createObject(e)).toList();
      } else {
        List<T> filteredList = [];
        for (var rowData in fileData) {
          T row = createObject(rowData);
          if (filterFunction(row)) {
            filteredList.add(row);
          }
        }
        return filteredList;
      }
    } catch (e) {
      log('Error : ${e.toString()}');
      return [];
    }
  }

  @override
  Future<bool> addRowToRawTable(String tableName, JSONModel object,
      bool Function(JSONModel object)? validationFunciton) async {
    String jsonFileName = tableName;
    try {
      List<dynamic> jsonList = [];
      try {
        // Get the json file from the assets folder
        final String jsonString =
            await rootBundle.loadString('assets/data/$jsonFileName.json');

        // Convert the json string to a list of objects
        jsonList = jsonDecode(jsonString);
      } catch (e) {
        log('Error while reading the json file: $e');
        return false;
      }

      if (validationFunciton != null) {
        for (var element in jsonList) {
          if (!validationFunciton(element)) {
            return false;
          }
        }
      }
      // Add the new object to the list
      jsonList.add(object.toJson());

      // Convert the list back to a json string
      String newJsonString = jsonEncode(jsonList);

      try {
        // Write the new string back to the file
        await io.File('assets/data/$jsonFileName.json')
            .writeAsString(newJsonString);
        return true;
      } catch (e) {
        log('Error while writing the json file: $e');
        return false;
      }
    } catch (e) {
      log('Error : ${e.toString()}');
      return false;
    }
  }

  @override
  Future<void> deleteRowToRawTable(String tableName, id) {
    // TODO: implement deleteRowToRawTable
    throw UnimplementedError();
  }

  @override
  Future<List<Equatable>> filterRawTableRows(
      String tableName, bool Function(Equatable object) where) {
    // TODO: implement filterRawTableRows
    throw UnimplementedError();
  }

  @override
  Future<void> updateJsonSource(String tableName, List<JSONModel> rows) {
    // TODO: implement updateJsonSource
    throw UnimplementedError();
  }

  @override
  Future<void> updateRowToRawTable(String tableName, id, JSONModel row) {
    // TODO: implement updateRowToRawTable
    throw UnimplementedError();
  }

  // Future<DailyReport> getDailyReport(
  //     StationDetails stationDetails, DateTime date) async {
  //   DailyReport dailyReport = DailyReport(
  //     stationDetails: stationDetails,
  //     currentDate: date,
  //   );
  //   dailyReport = await getTanksMeasurmentsForDailyReport(dailyReport);

  //   return dailyReport;
  // }

  // Future<DailyReport> getTanksMeasurmentsForDailyReport(
  //     DailyReport dailyReport) async {
  //   var tanksDailyMeasurmentsTable =
  //       await getTanksDailyMeasurementslist(dailyReport.stationDetails);
  //   tanksDailyMeasurmentsTable.rows.sort((a, b) => b
  //       .rowData[TanksDailyMeasurement.DATE]
  //       .compareTo(a.rowData[TanksDailyMeasurement.DATE]));
  //   dailyReport.currentTanksMeasurments = tanksDailyMeasurmentsTable.rows
  //       .firstWhere((element) => element.rowData[TanksDailyMeasurement.DATE]
  //           .isAtSameMomentAs(dailyReport.currentDate));
  //   dailyReport.prevTanksMeasurments =
  //       tanksDailyMeasurmentsTable.rows.firstWhere((element) {
  //     DateTime elementDate = element.rowData[TanksDailyMeasurement.DATE];
  //     if (elementDate.isBefore(dailyReport.currentDate)) {
  //       dailyReport.prevDate = elementDate;
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   });
  //   return dailyReport;
  // }

  // Future<DateTime> getPrevDate(
  //     StationDetails stationDetails, DateTime date) async {
  //   var tanksDailyList = await getTanksDailyMeasurementslist(stationDetails);
  //   List<DateTime> dates = [];
  //   for (var element in tanksDailyList.dataList) {
  //     date.add(element.toJson()[TanksDailyMeasurementJSONModel.DATE]);
  //   }
  //   //sort dates in descending order
  //   dates.sort((a, b) => b.compareTo(a));
  //   return dates.firstWhere((dailyDate) => dailyDate.isBefore(date));
  // }

  // Future<StationDetails> getStationDetails(StationJSONModel station) async {
  //   Map<int, String> tanksMap = {};
  //   List<TankJSONModel> tanksList = await getRawTableRows<TankJSONModel>(
  //       TankJSONModel.TABLENAME, (tank) => TankJSONModel.fromJson(tank),
  //       (tank) {
  //     return tank.stationName == station.name ? true : false;
  //   });
  //   for (var tank in tanksList) {
  //     tanksMap[tank.id] = tank.name;
  //   }
  //   return StationDetails(station: station, tanks: tanksMap);
  // }

  // Future<ExpandedTable> getTanksDailyMeasurementslist(
  //     StationDetails stationDetails) async {
  //   ExpandedTable expandedTable = ExpandedTable([], {});

  //   // log(tanksMap.toString());
  //   List<TanksDailyMeasurementJSONModel> tanksDailylist = await getRawTableRows<
  //           TanksDailyMeasurementJSONModel>(
  //       TanksDailyMeasurementJSONModel.TABLENAME,
  //       (tanksDailyMeasurementJson) =>
  //           TanksDailyMeasurementJSONModel.fromJson(tanksDailyMeasurementJson),
  //       (tanksDailyMeasurement) {
  //     return stationDetails.tanks.containsKey(tanksDailyMeasurement.id)
  //         ? true
  //         : false;
  //   });
  //   // log(tanksNameList[0].toString());
  //   // log(tanksNoList.toString());
  //   expandedTable.columns[TanksDailyMeasurementJSONModel.DATE] = DateTime;
  //   stationDetails.tanks.forEach(
  //     (key, value) {
  //       expandedTable.columns[value] = double;
  //     },
  //   );
  //   expandedTable.dataList =
  //       _convertRowData(tanksDailylist, stationDetails.tanks);
  //   return expandedTable;
  // }

  List<ExpandedRowModel> _convertRowData(
      List<TanksDailyMeasurementJSONModel> list, Map<int, String> tanksMap) {
    List<ExpandedRowModel> expandedList = [];
    for (TanksDailyMeasurementJSONModel row in list) {
      ExpandedRowModel expandedRow = expandedList.firstWhere(
          (element) =>
              row.date == element.rowData[TanksDailyMeasurementJSONModel.DATE],
          orElse: () {
        // TablableModel.mapEntitytoModel[ExpandedRowEntity]!({})
        var element = ExpandedRowModel(
          id: row.date,
          rowData: {TanksDailyMeasurementJSONModel.DATE: row.date},
        );
        expandedList.add(element);
        return element;
      });
      expandedRow.rowData[tanksMap[row.tankNo]!] = row.quantity;
    }
    return expandedList;
  }

  // Future<ExpandedTable> getTanksEquilibriumlist(
  //     StationJSONModel station) async {
  //   ExpandedTable expandedTable = ExpandedTable([], {});

  //   List<TanksProductsJSONModel> tanksProductsList =
  //       await getRawTableRows<TanksProductsJSONModel>(
  //           TanksProductsJSONModel.TABLENAME,
  //           (tankProduct) => TanksProductsJSONModel.fromJson(tankProduct));
  //   // log(tanksProductsList.toString());
  //   var tanksEquilibriumQuantitylist = await getRawTableRows(
  //       TankEquilibriumQuantityJSONModel.TABLENAME,
  //       (tanksEquilibriumQuantityJson) =>
  //           TankEquilibriumQuantityJSONModel.fromJson(
  //               tanksEquilibriumQuantityJson), (tanksEquilibriumQuantity) {
  //     return (tanksEquilibriumQuantity.stationName == station.name)
  //         ? true
  //         : false;
  //   });
  //   // log(tanksNameList[0].toString());
  //   // log(tanksNoList.toString());
  //   expandedTable.columns[TankEquilibriumQuantityJSONModel.DATE] = DateTime;
  //   for (var value in tanksProductsList) {
  //     expandedTable.columns[value.product] = double;
  //   }
  //   expandedTable.columns[TankEquilibriumQuantityJSONModel.NOTES] = String;
  //   expandedTable.dataList = _convertEquilibriumRowData(
  //       tanksEquilibriumQuantitylist, tanksProductsList);
  //   return expandedTable;
  // }

  List<ExpandedRowModel> _convertEquilibriumRowData(
      List<TankEquilibriumJSONModel> list,
      List<TankProductJSONModel> productsList) {
    List<ExpandedRowModel> expandedList = [];
    for (TankEquilibriumJSONModel row in list) {
      ExpandedRowModel expandedRow = expandedList.firstWhere(
          (element) =>
              row.date == element.rowData[TankEquilibriumJSONModel.DATE],
          orElse: () {
        var element = ExpandedRowModel(
          id: row.date,
          rowData: {TankEquilibriumJSONModel.DATE: row.date},
        );
        for (var tanksProduct in productsList) {
          element.rowData[tanksProduct.product] = 0;
        }

        expandedList.add(element);
        return element;
      });
      expandedRow.rowData[TankEquilibriumJSONModel.NOTES] = row.notes;
      expandedRow.rowData[row.productName] = row.quantity;
    }
    return expandedList;
  }
}

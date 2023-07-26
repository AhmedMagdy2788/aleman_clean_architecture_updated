import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../core/entities/expanded_row_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/models/server_model.dart';
import '../../domain/entities/station_entity.dart';
import '../../presentation/bloc/tablable_entities/station_details.dart';

abstract class RawTableDBDataSource {
  /// Calls the http:numbersapi.com/{number} endpoint
  ///
  /// Throw a [ServerException] for all error codes.
  // Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [ServerExceptoin] for all error codes.
  // Future<NumberTriviaModel> getRandomNumberTrivia();
  Future<DailyReport> getDailyReport(
      StationEntity station, DateTime reportDate);

  Future<List<Model>> getRawTableRows<Model>(
      String endPoint, Model Function(Map<String, dynamic>) createObject,
      [String? requestParams,
      Map<String, dynamic> header = const {},
      bool Function(Model)? filterFunction]);

  Future<Model> getRawTableRow<Model>(
      String endPoint, Model Function(Map<String, dynamic>) createObject,
      [String requestParams, Map<String, dynamic> header = const {}]);

  Future<List<Map<String, dynamic>>> getRawExpandedTableRows(String endPoint,
      [String? requestParams, bool Function(dynamic)? filterFunction]);

  Future<Model> addRowToRawTable<Model>(String endPoint, ServerModel object,
      Model Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]);

  Future<ServerAddRangeResponseModel> addRangeOfRows(
      String endPoint,
      List<ServerModel> modelList,
      ServerModel Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]);

  Future<Model> updateRowToRawTable<Model>(
      String endPoint,
      Map<String, dynamic> id,
      ServerModel row,
      Model Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]);

  Future<Model> deleteRowToRawTable<Model>(
      String endPoint,
      Map<String, dynamic> id,
      Model Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]);

  // Future<void> updateJsonSource(String tableName, List<ServerModel> rows);
}

class RawTableDBDataSourceImpl implements RawTableDBDataSource {
  String uriLink;
  RawTableDBDataSourceImpl({required this.uriLink});

  @override
  Future<Model> getRawTableRow<Model>(
      String endPoint, Model Function(Map<String, dynamic>) createObject,
      [String requestParams = "",
      Map<String, dynamic> header = const {}]) async {
    var client = http.Client();
    try {
      String fullUri = uriLink + endPoint + requestParams;
      print(fullUri);
      final response = await client.get(
        Uri.parse(fullUri),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'text/plain',
          ...header
        },
      );
      if (response.statusCode == 200) {
        var decodedModel = json.decode(response.body);
        print(response.body);
        return createObject(decodedModel);
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      print('https request error: ${e.toString()}');
      throw ServerException('https request error: ${e.toString()}');
    } finally {
      client.close();
    }
  }

  @override
  Future<List<Model>> getRawTableRows<Model>(
      String endPoint, Model Function(Map<String, dynamic>) createObject,
      [String? requestParams,
      Map<String, dynamic> header = const {},
      bool Function(Model p1)? filterFunction]) async {
    var client = http.Client();
    List<Model> filteredList = [];
    try {
      String fullUri = uriLink + endPoint;
      if (requestParams != null) fullUri += requestParams;
      print(fullUri);
      final response = await client.get(
        Uri.parse(fullUri),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'text/plain',
          ...header
        },
      );
      if (response.statusCode == 200) {
        var jsonList = json.decode(response.body);
        log(response.body);
        if (filterFunction == null) {
          for (var element in jsonList) {
            log(element.toString());
            filteredList.add(createObject(element));
          }
        } else {
          for (var rowData in jsonList) {
            Model row = createObject(rowData);
            log(rowData.toString());
            if (filterFunction(row)) {
              filteredList.add(row);
            }
          }
        }
        return filteredList;
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      log('https request error: ${e.toString()}');
      throw ServerException('https request error: ${e.toString()}');
    } finally {
      client.close();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getRawExpandedTableRows(String endPoint,
      [String? requestParams, bool Function(dynamic)? filterFunction]) async {
    var client = http.Client();
    try {
      String fullUri = uriLink + endPoint;
      if (requestParams != null) fullUri += requestParams;
      log(fullUri);
      final response = await client.get(
        Uri.parse(fullUri),
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
      );
      if (response.statusCode == 200) {
        // log(response.body);
        List<Map<String, dynamic>> mapList = [];
        var jsonList = json.decode(response.body);
        for (var element in jsonList) {
          log(element.toString());
          mapList.add(element);
        }
        return mapList;
      } else {
        throw ServerException(response.body);
      }
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> _dbRequest(String endPoint,
      [String? requestParams]) async {
    var client = http.Client();
    try {
      String fullUri = uriLink + endPoint;
      if (requestParams != null) fullUri += requestParams;
      // log(fullUri);
      final response = await client.get(
        Uri.parse(fullUri),
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
      );
      if (response.statusCode == 200) {
        // log(response.body);
        return json.decode(response.body);
      } else {
        throw ServerException(response.body);
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<DailyReport> getDailyReport(
      StationEntity station, DateTime reportDate) async {
    try {
      DailyReport report = DailyReport(
        currentDate: reportDate,
        stationDetails: StationDetails(station: station),
      );
      //* get previous Daily Report Date *//
      var prevDateResulte = await _dbRequest(
          "DailyReposrt/getPreviousDailyDate",
          '?date=${DateFormat("yyyy-MM-dd").format(reportDate)}&stationName=${station.name}');
      log(prevDateResulte[0]["prevDate"]);
      report.prevDate = DateTime.parse(prevDateResulte[0]["prevDate"]);

      //* get current tanks measurments *//
      var currentTanksMeasurmentsResulte = await _dbRequest(
          "TanksQuantities/GetExpandedTanksQuantityByStationNameAndDate",
          '?date=${DateFormat("yyyy-MM-dd").format(reportDate)}&stationName=${station.name}');
      report.currentTanksMeasurments = ExpandedRowEntity(
          id: currentTanksMeasurmentsResulte[0]["Registeration Date"],
          rowData: currentTanksMeasurmentsResulte[0]);

      //* get previous tanks measurments *//
      var prevTanksMeasurmentsResulte = await _dbRequest(
          "TanksQuantities/GetExpandedTanksQuantityByStationNameAndDate",
          '?date=${DateFormat("yyyy-MM-dd").format(report.prevDate)}&stationName=${station.name}');
      report.prevTanksMeasurments = ExpandedRowEntity(
          id: prevTanksMeasurmentsResulte[0]["Registeration Date"],
          rowData: prevTanksMeasurmentsResulte[0]);

      //* get current tanks product type *//
      var responce = await _dbRequest(
          "TanksContentType/GetExpandedTanksContentTypeByStationNameAndDate",
          '?date=${DateFormat("yyyy-MM-dd").format(reportDate)}&stationName=${station.name}');
      Map<String, dynamic> currentTanksProductsTypeResulte =
          jsonDecode(responce[0]["tanks_content_products"]);
      log(currentTanksProductsTypeResulte.toString());
      report.currentTanksProductType = ExpandedRowEntity(
          id: currentTanksProductsTypeResulte["Date"],
          rowData: currentTanksProductsTypeResulte);

      //* get previous tanks product type *//
      responce = await _dbRequest(
          "TanksContentType/GetExpandedTanksContentTypeByStationNameAndDate",
          '?date=${DateFormat("yyyy-MM-dd").format(report.prevDate)}&stationName=${station.name}');
      Map<String, dynamic> prevTanksProductsTypeResulte =
          jsonDecode(responce[0]["tanks_content_products"]);
      log(prevTanksProductsTypeResulte.toString());
      report.prevTanksProductType = ExpandedRowEntity(
          id: prevTanksProductsTypeResulte["Date"],
          rowData: prevTanksProductsTypeResulte);

      return report;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Model> addRowToRawTable<Model>(String endPoint, ServerModel object,
      Model Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]) async {
    var client = http.Client();
    try {
      String fullUri = uriLink + endPoint;
      //'https://localhost:7072/api/Tanks/Addtank'
      final url = Uri.parse(fullUri);
      final requestHeaders = {
        'accept': '*/*',
        'Content-Type': 'application/json',
        ...headers
      };
      // var objectJson = object.toJson();
      // log("object json: $objectJson");
      final body = jsonEncode(object);
      log("Requist Body: $body");
      final response =
          await client.post(url, headers: requestHeaders, body: body);
      // handle response
      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonObject = json.decode(response.body);
        return createModel(jsonObject);
      } else {
        throw ServerException("faild add=> response body : ${response.body}");
      }
    } catch (e) {
      log('error while adding ${object.toJson()}');
      log('https request error: ${e.toString()}');
      throw ServerException("https request error: ${e.toString()}");
    } finally {
      client.close();
    }
  }

  @override
  Future<ServerAddRangeResponseModel> addRangeOfRows(
      String endPoint,
      List<ServerModel> modelList,
      ServerModel Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]) {
    // TODO: implement addRangeOfRows
    throw UnimplementedError();
  }

  @override
  Future<Model> deleteRowToRawTable<Model>(
      String endPoint,
      Map<String, dynamic> id,
      Model Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]) async {
    var client = http.Client();
    try {
      ///api/PumpsTanksDetails/DeletePumpsTanksDetail
      String fullUri = "$uriLink$endPoint?";
      id.forEach((key, value) {
        fullUri += "$key=$value&";
      });
      fullUri = fullUri.substring(0, fullUri.length - 1);
      final url = Uri.parse(fullUri);
      final requestHeaders = {
        'accept': '*/*',
        'Content-Type': 'application/json',
        ...headers
      };
      final response = await client.delete(url, headers: requestHeaders);
      // handle response
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonObject = json.decode(response.body);
        return createModel(jsonObject);
      } else {
        throw ServerException(
            "faild delete=> response body : ${response.body}");
      }
    } catch (e) {
      log('error while deleting $id');
      log('https request error: ${e.toString()}');
      throw ServerException("https request error: ${e.toString()}");
    } finally {
      client.close();
    }
  }

  @override
  Future<Model> updateRowToRawTable<Model>(
      String endPoint,
      Map<String, dynamic> id,
      ServerModel row,
      Model Function(Map<String, dynamic> modelAsJSON) createModel,
      [Map<String, String> headers = const {}]) async {
    var client = http.Client();
    try {
      String fullUri = "$uriLink$endPoint?";
      id.forEach((key, value) {
        fullUri += "$key=$value&";
      });
      fullUri = fullUri.substring(0, fullUri.length - 1);
      print(fullUri);
      final url = Uri.parse(fullUri);
      final requestHeaders = {
        'accept': '*/*',
        'Content-Type': 'application/json',
        ...headers
      };
      var objectJson = row.toJson();
      log("object json: $objectJson");
      final body = jsonEncode(objectJson);
      log("Requist Body: $body");
      final response =
          await client.put(url, headers: requestHeaders, body: body);
      // handle response
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonObject = json.decode(response.body);
        return createModel(jsonObject);
      } else if (response.statusCode == 204) {
        return createModel(objectJson);
      } else {
        throw ServerException(
            "faild update=> response body : ${response.body}");
      }
    } catch (e) {
      log('error while updating ${row.toJson()}');
      log('https request error: ${e.toString()}');
      throw ServerException("https request error: ${e.toString()}");
    } finally {
      client.close();
    }
  }
}

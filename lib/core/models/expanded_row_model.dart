// ignore_for_file: constant_identifier_names

import 'json_model.dart';

import '../entities/expanded_row_entity.dart';

class ExpandedRowModel extends ExpandedRowEntity implements JSONModel {
  static const String ROW_DATA = "row_data";
  static const String ROW_ID = "row_id";

  ExpandedRowModel({required super.id, required super.rowData});

  factory ExpandedRowModel.fromJson(Map<String, dynamic> json) {
    return ExpandedRowModel(id: json[ROW_ID], rowData: json[ROW_DATA]);
  }

  @override
  String toString() => toJson().toString();
}

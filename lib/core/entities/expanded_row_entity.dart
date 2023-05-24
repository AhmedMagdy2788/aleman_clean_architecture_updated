// ignore_for_file: constant_identifier_names

import 'tablable_entity.dart';

class ExpandedRowEntity extends TablableEntity<Map<String, dynamic>> {
  Map<String, dynamic> get rowData => entity;
  set rowData(Map<String, dynamic> data) => entity = data;

  @override
  final dynamic id;

  ExpandedRowEntity({
    required this.id,
    required Map<String, dynamic> rowData,
  }) : super(rowData);

  @override
  Map<String, dynamic> toJson() => entity;

  @override
  bool selected = false;
}

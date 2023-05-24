// ignore_for_file: constant_identifier_names

import 'tablable_entity.dart';

class ExpandedTableDataSource extends TableDataSource<Map<String, dynamic>> {
  static const String DATA_ROWS = "data_rows";
  static const String DATA_COLUMNS = "data_columns";

  @override
  Map<String, Type> columns;

  ExpandedTableDataSource(
      {required super.dataList, required super.title, required this.columns});
  //   : super(dataList: []) {
  // for (var element in equatableDataList) {
  //   super.dataList.add(ExpandedTablable(element));
  // }
  // }
}

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/entities/expanded_row_entity.dart';
import 'tablable_entity.dart';

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class DataSource<T> extends DataTableSource {
  int _selectedCount = 0;
  final BuildContext context;
  final TableDataSource<T> tableData;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = true;
  // Override height values for certain rows
  bool hasRowHeightOverrides = true;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  // DataSource.empty(this.context) {
  //   tablableDataRows = [];
  // }
  // DataSource.fromExpandedTable(
  //     {required this.context, required ExpandedTable table}) {
  //   tableData.dataList = table.rows;
  //   tableData.columns = table.columns;
  //   hasRowTaps = false;
  //   hasRowHeightOverrides = false;
  //   hasZebraStripes = true;
  // }

  DataSource(
    this.context,
    this.tableData, [
    this.hasRowTaps = false,
    this.hasRowHeightOverrides = false,
    this.hasZebraStripes = true,
  ]);

  void sortColumn(String columnName, bool ascending) {
    // log(columnName);
    tableData.dataList.sort((tab1, tab2) {
      int compResult;
      compResult = ascending
          ? tab1.toJson()[columnName].compareTo(tab2.toJson()[columnName])
          : tab2.toJson()[columnName].compareTo(tab1.toJson()[columnName]);
      return compResult;
    });
    notifyListeners();
  }

  // void sort<T>(
  //     Comparable<T> Function(TablableEntity d) getField, bool ascending) {
  //   dataRows.sort((a, b) {
  //     final aValue = getField(a);
  //     final bValue = getField(b);
  //     return ascending
  //         ? Comparable.compare(aValue, bValue)
  //         : Comparable.compare(bValue, aValue);
  //   });
  //   notifyListeners();
  // }

  void updateSelectedRows(RestorableDataSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < tableData.dataList.length; i += 1) {
      var rowData = tableData.dataList[i];
      if (selectedRows.isSelected(i)) {
        rowData.selected = true;
        _selectedCount += 1;
      } else {
        rowData.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    assert(index >= 0);
    if (index >= tableData.dataList.length) throw 'index > dataList.length';
    final rowData = tableData.dataList[index];
    return DataRow2.byIndex(
      index: index,
      selected: rowData.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onSelectChanged: (value) {
        if (rowData.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          rowData.selected = value;
          notifyListeners();
        }
      },
      onTap: hasRowTaps
          ? () => _showSnackbar(context, 'Tapped on row ${rowData.id}')
          : null,
      onDoubleTap: hasRowTaps
          ? () => _showSnackbar(context, 'Double Tapped on row ${rowData.id}')
          : null,
      onLongPress: hasRowTaps
          ? () => _showSnackbar(context, 'Long pressed on row ${rowData.id}')
          : null,
      onSecondaryTap: hasRowTaps
          ? () => _showSnackbar(context, 'Right clicked on row ${rowData.id}')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) =>
              _showSnackbar(context, 'Right button down on row ${rowData.id}')
          : null,
      // specificRowHeight: 100,
      // hasRowHeightOverrides && rowData.fat >= 25 ? 100 : null,
      cells: [...cellsDataRows(context, rowData)],
    );
  }

  @override
  int get rowCount => tableData.dataList.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final dessert in tableData.dataList) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? tableData.dataList.length : 0;
    notifyListeners();
  }

  _showSnackbar(BuildContext context, String text, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      content: Text(text),
    ));
  }

  List<DataCell> cellsDataRows(BuildContext context, TablableEntity tablable) {
    List<DataCell> cells = [];
    if (tablable is ExpandedRowEntity) {
      tableData.columns.forEach((colName, colType) {
        cells.add(buildDataCell(context,
            formatTextCell(context, tablable.rowData[colName]), () {}));
      });
    } else {
      for (var prop in tablable.entity.props) {
        cells.add(buildDataCell(context, formatTextCell(context, prop), () {}));
      }
    }
    return cells;
  }
}

String formatTextCell(context, dynamic value) {
  Locale myLocale = Localizations.localeOf(
      context); /* gets the locale based on system language*/

  String languageCode = myLocale.languageCode;
  switch (value.runtimeType) {
    case DateTime:
      return DateFormat('dd-MMM-yyyy').format(value);
    case int:
      final format = NumberFormat.decimalPattern(languageCode);
      return format.format(value);
    case double:
      final format = NumberFormat("#,###.0#");
      return format.format(value);
    default:
      return value.toString();
  }
}

DataCell buildDataCell(
    BuildContext context, String value, void Function() onTap,
    [bool isEditable = false]) {
  return DataCell(
    Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          VerticalDivider(
            thickness: 3,
            endIndent: 15,
            color: Theme.of(context).dividerColor,
            indent: 15,
            width: 10,
          ),
          const Spacer(flex: 1),
          Flexible(
            flex: 11,
            child: Text(
              value,
            ),
          ),
        ],
      ),
    ),
    showEditIcon: isEditable, //isCellsEditable,
    onTap: onTap,
  );
}

/// Keeps track of selected rows, feed the data into DesertsDataSource
class RestorableDataSelections extends RestorableProperty<Set<int>> {
  Set<int> _dataSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dataSelections.contains(index);

  /// Takes a list of [Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDataSelections(List<TablableEntity> data) {
    final updatedSet = <int>{};
    for (var i = 0; i < data.length; i += 1) {
      var element = data[i];
      if (element.selected) {
        updatedSet.add(i);
      }
    }
    _dataSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dataSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dataSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dataSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dataSelections = value;
  }

  @override
  Object toPrimitives() => _dataSelections.toList();
}

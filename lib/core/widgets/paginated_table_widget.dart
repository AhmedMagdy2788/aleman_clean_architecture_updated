import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../customs/paginated_table_helper/custom_pager.dart';
import '../customs/paginated_table_helper/nav_helper.dart';
import '../entities/data_source.dart';
import '../entities/tablable_entity.dart';

class PaginatedTableWidget extends StatefulWidget {
  final String title;
  final DataSource dataSource;
  final bool Function(List<TablableEntity>)? filter;
  const PaginatedTableWidget({
    super.key,
    required this.title,
    required this.dataSource,
    this.filter,
  });

  @override
  State<PaginatedTableWidget> createState() => _PaginatedTableWidgetState();
}

class _PaginatedTableWidgetState extends State<PaginatedTableWidget> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  bool _initialized = false;
  PaginatorController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // widget.dataSource = DessertDataSource(
      //     context, getCurrentRouteOption(context) == defaultSorting);

      _controller = PaginatorController();

      if (getCurrentRouteOption(context) == defaultSorting) {
        _sortColumnIndex = 1;
      }
      _initialized = true;
    }
  }

  void sortColumn(int columnIndex, bool ascending, String columnName) {
    widget.dataSource.sortColumn(columnName, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      // mySortColumn(columnIndex, ascending);
    });
  }

  // void sort<T>(
  //   Comparable<T> Function(TablableEntity d) getField,
  //   int columnIndex,
  //   bool ascending,
  // ) {
  //   widget.dataSource.sort<T>(getField, ascending);
  //   setState(() {
  //     _sortColumnIndex = columnIndex;
  //     _sortAscending = ascending;
  //   });
  // }

  @override
  void dispose() {
    widget.dataSource.dispose();
    super.dispose();
  }

  List<DataColumn> get _columns {
    List<DataColumn> columns = [];
    widget.dataSource.tableData.columns.forEach((columnName, columnType) {
      columns.add(DataColumn(
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              VerticalDivider(
                thickness: 3,
                endIndent: 10,
                color: Theme.of(context).dividerColor,
                indent: 10,
                width: 10,
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                // flex: 9,
                child: Text(
                  columnName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              // const Spacer(),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                itemBuilder: ((context) => [
                      const PopupMenuItem(
                          child: ListTile(title: Text("Fileter")))
                    ]),
                icon: const Center(child: Icon(Icons.more_vert)),
              ),
            ],
          ),
        ),
        // numeric: value == int || value == double ? true : false,
        onSort: (columnIndex, ascending) =>
            sortColumn(columnIndex, ascending, columnName),
        // sort<>((d) => d, columnIndex, ascending),
      ));
    });
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      PaginatedDataTable2(
        horizontalMargin: 20,
        checkboxHorizontalMargin: 12,
        columnSpacing: 0,
        wrapInCard: true,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.black54),
        header:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(widget.title),
          // if (kDebugMode && getCurrentRouteOption(context) == custPager)
          Row(children: [
            OutlinedButton(
                onPressed: () => _controller!.goToPageWithRow(25),
                child: const Text('Go to row 25')),
            OutlinedButton(
                onPressed: () => _controller!.goToRow(5),
                child: const Text('Go to row 5'))
          ]),
          // if (getCurrentRouteOption(context) == custPager &&
          //     _controller != null)
          PageNumber(controller: _controller!)
        ]),
        rowsPerPage: _rowsPerPage,
        // autoRowsToHeight: getCurrentRouteOption(context) == autoRows,
        minWidth: 200,
        fit: FlexFit.tight,
        border: const TableBorder(
            top: BorderSide(color: Colors.black54),
            bottom: BorderSide(color: Colors.white),
            left: BorderSide(color: Colors.black54),
            right: BorderSide(color: Colors.black54),
            verticalInside:
                BorderSide.none, //BorderSide(color: Colors.grey[300]!),
            horizontalInside: BorderSide(color: Colors.grey, width: 2)),
        onRowsPerPageChanged: (value) {
          // No need to wrap into setState, it will be called inside the widget
          // and trigger rebuild
          //setState(() {
          _rowsPerPage = value!;
          log(_rowsPerPage.toString());
          //});
        },
        initialFirstRowIndex: 0,
        onPageChanged: (rowIndex) {
          log('${rowIndex / _rowsPerPage}');
        },
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
        sortArrowAnimationDuration:
            const Duration(milliseconds: 250), // custom animation duration
        onSelectAll: widget.dataSource.selectAll,
        controller:
            getCurrentRouteOption(context) == custPager ? _controller : null,
        hidePaginator: getCurrentRouteOption(context) == custPager,
        columns: _columns,
        dataRowHeight: 60,
        empty: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey[200],
                child: const Text('No data'))),
        source: widget.dataSource,
        //my new edited 29-3-2023
        autoRowsToHeight: true,
        renderEmptyRowsInTheEnd: false,
        availableRowsPerPage: const [10, 15, 20],
        fixedCornerColor: Colors.amber,
        // getCurrentRouteOption(context) == noData
        //     ? DataSource.empty(context)
        //     : widget.dataSource,
      ),
      if (getCurrentRouteOption(context) == custPager)
        Positioned(bottom: 16, child: CustomPager(_controller!))
    ]);
  }
}

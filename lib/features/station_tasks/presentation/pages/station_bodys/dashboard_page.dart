import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../../core/entities/data_source.dart';
import '../../../../../core/entities/tablable_entity.dart';
import '../../../../../core/widgets/my_custom_paginated_data_table.dart';
import '../../../domain/entities/station_entity.dart';
import '../../bloc/tablable_entities/station_tablable.dart';
import '../../widgets/stations/page_header.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TableDataSource<StationEntity> tableDataSource = StationTableDataSouce([
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
    const StationEntity(
        id: 1,
        name: "name",
        ownerCompany: "ownerCompany",
        location: "location",
        partner: "null"),
  ]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Flexible(
          flex: 1,
          child: Center(
            child: PageHeader(
                title: "Dashboard", subTitle: "Welcome to your dashboard"),
          ),
        ),
        Flexible(
          flex: 11,
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight,
                  child: MyCustomPaginatedDataTable(
                    dataSource: DataSource(context, tableDataSource),
                    tableTitle: 'Custom Paginated Table',
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight,
                  child: MyDataTable<StationEntity>(
                    dataSource: MyDataTableSource(context, tableDataSource),
                    tableTitle: 'Custom Paginated Table',
                  ),
                  // GridPaginatedDataTable(
                  //   dataSource: DataSource(context, tableDataSource),
                  //   tableTitle: 'Custom Paginated Table',
                  // ),
                )
              ],
            );
          }),
        ),
      ],
    ));
  }
}

class MyDataTable<T> extends StatelessWidget {
  const MyDataTable(
      {super.key,
      required this.dataSource,
      this.rowHeight = 60,
      required this.tableTitle});

  final MyDataTableSource dataSource;
  final String tableTitle;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: PaginatedDataTable2(
        header: const SelectableText('My Data Table'),
        headingRowColor: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return green, otherwise blue
          // if (states.contains(MaterialState.pressed)) {
          //   return Colors.green;
          // }
          return Colors.black38;
        }),
        border: const TableBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          verticalInside:
              BorderSide(width: 4, color: Color.fromARGB(104, 109, 109, 110)),
        ),
        autoRowsToHeight: true,
        dividerThickness: 2,
        headingRowHeight: 70,
        dataRowHeight: 60,
        columnSpacing: 30,
        renderEmptyRowsInTheEnd: false,
        showCheckboxColumn: true,
        showFirstLastButtons: true,
        wrapInCard: true,
        sortArrowIcon: Icons.arrow_upward,
        availableRowsPerPage: const [10, 15, 20],
        fixedCornerColor: Colors.amber,
        checkboxHorizontalMargin: 16,
        // rowsPerPage: 15,
        // columnWidths: {
        //   0: IntrinsicColumnWidth(),
        //   1: IntrinsicColumnWidth(),
        //   2: IntrinsicColumnWidth(),
        // },
        columns: generateDataColumns(),
        source: dataSource,
      ),
    );
  }

  List<DataColumn2> generateDataColumns() {
    List<DataColumn2> columns = [];
    dataSource.tableData.columns.forEach((key, value) {
      // const IntrinsicColumnWidth();
      columns.add(DataColumn2(
        label: SelectableText(key),
        size: ColumnSize.M,
      ));
    });
    return columns;
  }
}

class MyDataTableSource<T> extends DataTableSource {
  MyDataTableSource(this.context, this.tableData);
  final BuildContext context;
  final TableDataSource<T> tableData;
  bool switcher = false;

  @override
  DataRow getRow(int index) {
    switcher = !switcher;
    return DataRow2(
      cells: [
        DataCell(SelectableText('A' * (index + 1))),
        DataCell(SelectableText('B' * (index + 1))),
        DataCell(SelectableText('C' * (index + 1))),
        DataCell(SelectableText('C' * (index + 1))),
        DataCell(SelectableText('C' * (index + 1))),
      ],

      color: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return green, otherwise blue
        // if (states.contains(MaterialState.pressed)) {
        if (index.isEven) {
          // MaterialStateProperty.all(Theme.of(context).highlightColor);
          return Colors.grey[800];
        }
        return Colors.grey[600];
      }),
      onSelectChanged: (isSelected) {},
      // selected: true,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}

import 'package:flutter/material.dart';

import '../entities/data_source.dart';

class GridPaginatedDataTable extends StatefulWidget {
  final DataSource dataSource;
  final String tableTitle;
  const GridPaginatedDataTable(
      {super.key, required this.dataSource, required this.tableTitle});

  @override
  State<GridPaginatedDataTable> createState() => _GridPaginatedDataTableState();
}

class _GridPaginatedDataTableState extends State<GridPaginatedDataTable> {
  var headers = [
    const GridHeaderDataTable(
      title: "ID",
      hintString: "الرقم التعريفي للمحطة",
      headerHeight: 50,
      headerWidth: 50,
    ),
    const GridHeaderDataTable(
      title: "Name",
      hintString: "اسم المحطة",
      headerHeight: 50,
      headerWidth: 75,
    ),
    const GridHeaderDataTable(
      title: "Owner Company",
      hintString: "الشركة المالكة للمحطة",
      headerHeight: 50,
      headerWidth: 150,
    ),
    const GridHeaderDataTable(
      title: "Location",
      hintString: "موقع المحطة",
      headerHeight: 50,
      headerWidth: 75,
    ),
    const GridHeaderDataTable(
      title: "Partner",
      hintString: "توكيل المحطة",
      headerHeight: 50,
      headerWidth: 75,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: Column(
            children: [
              gridTableHeader(context),
              buildGridTableBody(context),
              gridTableFooter(context),
            ],
          ),
        );
      },
    );
  }

  Widget gridTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          SelectableText(
            widget.tableTitle,
            style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).textTheme.titleLarge?.color),
          ),
          const Spacer(),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }

  Widget buildGridTableBody(BuildContext context) {
    return Expanded(
      child: Column(children: [
        GridColumnsHeaderDataTable(
          headers: headers,
        ),
        // ...widget.dataSource.
      ]),
    );
  }

  Widget gridTableFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, -5))
          ],
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(8))),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          SelectableText(widget.tableTitle),
          const Spacer(),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}

class GridColumnsHeaderDataTable extends StatelessWidget {
  final List<GridHeaderDataTable> headers;

  const GridColumnsHeaderDataTable({
    super.key,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constaints) {
      return Container(
        color: Colors.black38,
        width: constaints.maxWidth,
        height: 50,
        child: Row(
          children: headers,
        ),
      );
    });
  }
}

class GridHeaderDataTable extends StatelessWidget {
  final String title;
  final String? hintString;
  final double headerWidth;
  final double headerHeight;
  const GridHeaderDataTable(
      {super.key,
      required this.title,
      this.hintString,
      required this.headerWidth,
      required this.headerHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: headerWidth,
      height: headerHeight,
      child: Row(children: [
        VerticalDivider(
            thickness: 3,
            endIndent: 5,
            color: Theme.of(context).dividerColor,
            indent: 5,
            width: 10),
        const Spacer(flex: 1),
        Flexible(
            flex: 11,
            child: Tooltip(message: hintString, child: SelectableText(title)))
      ]),
    );
  }
}

class MyCustomPaginatedDataTable extends StatelessWidget {
  const MyCustomPaginatedDataTable(
      {super.key,
      required this.dataSource,
      this.maxRowHeight = 60,
      this.minRowHeight = 30,
      required this.tableTitle});

  final DataSource dataSource;
  final String tableTitle;
  final double maxRowHeight;
  final double minRowHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return PaginatedDataTable(
        source: dataSource,
        columns: [
          buildDataColumn(context, "ID", "الرقم التعريفي للمحطة",
              columnWidth: 50),
          buildDataColumn(context, "Name", "اسم المحطة", columnWidth: 75),
          buildDataColumn(context, "Owner Company", "الشركة المالكة للمحطة",
              columnWidth: 150),
          buildDataColumn(context, "Location", "موقع المحطة"),
          buildDataColumn(context, "Partner", "توكيل المحطة"),
        ],
        columnSpacing: 0.0,
        showCheckboxColumn: true,
        horizontalMargin: 0,
        headingRowHeight: 50,
        checkboxHorizontalMargin: 0,
        availableRowsPerPage: const [5, 10, 15],
        dataRowMaxHeight: maxRowHeight,
        dataRowMinHeight: minRowHeight,
        showFirstLastButtons: true,
        rowsPerPage:
            ((constraints.maxHeight - 16 - 200) / maxRowHeight).round(),
        header: Row(
          children: [
            SelectableText(tableTitle),
            const Spacer(),
            const Icon(Icons.more_vert),
          ],
        ),
        actions: [
          Switch(value: true, onChanged: (value) {}),
          Switch(value: false, onChanged: (value) {}),
          Switch(value: false, onChanged: (value) {}),
          Switch(value: true, onChanged: (value) {}),
        ],
      );
    });
  }

  DataColumn buildDataColumn(BuildContext context, String title, String? hint,
      {double columnWidth = 100}) {
    return DataColumn(
      label: Container(
          width: columnWidth,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Row(children: [
            VerticalDivider(
              thickness: 3,
              endIndent: 5,
              color: Theme.of(context).dividerColor,
              indent: 5,
              width: 10,
            ),
            const Spacer(flex: 1),
            Flexible(flex: 11, child: SelectableText(title))
          ])),
      tooltip: hint,
    );
  }
}

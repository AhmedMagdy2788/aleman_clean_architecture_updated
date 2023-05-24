import 'package:flutter/material.dart';

import '../../../../../core/entities/data_source.dart';
import '../../../../../core/entities/tablable_entity.dart';
import '../../../../../core/widgets/paginated_table_widget.dart';

class SinglePaginatedTablePage<T> extends StatelessWidget {
  final TableDataSource<T> tableData;

  const SinglePaginatedTablePage({super.key, required this.tableData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PaginatedTableWidget(
        title: tableData.title,
        dataSource: DataSource(context, tableData),
      ),
    );
  }
}

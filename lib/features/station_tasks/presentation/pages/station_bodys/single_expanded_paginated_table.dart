import 'package:flutter/material.dart';

import '../../../../../core/entities/data_source.dart';
import '../../../../../core/entities/expanded_table.dart';
import '../../../../../core/widgets/paginated_table_widget.dart';

class SingleExpandedPaginatedTableWidget extends StatelessWidget {
  final ExpandedTableDataSource table;
  const SingleExpandedPaginatedTableWidget({required this.table, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PaginatedTableWidget(
      title: table.title,
      dataSource: DataSource(context, table),
    ));
  }
}

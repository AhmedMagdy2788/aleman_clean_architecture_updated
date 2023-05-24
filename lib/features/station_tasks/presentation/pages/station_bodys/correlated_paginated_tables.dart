import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/tablable_entity.dart';
import '../../../../../core/widgets/my_custom_paginated_data_table.dart';
import '../../bloc/correlated_data_table_bloc/correlated_data_bloc_bloc.dart';
import '../../../../../core/entities/data_source.dart';
import '../../../../../core/widgets/paginated_table_widget.dart';

class CorrelatedPaginatedTables<T, R> extends StatelessWidget {
  final TableDataSource<T> mainTableData;
  final TableDataSource<R> relatedTableData;
  const CorrelatedPaginatedTables(
      {super.key, required this.mainTableData, required this.relatedTableData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CorrelatedDataBlocBloc>(
      create: (context) =>
          CorrelatedDataBlocBloc<T, R>(mainTableData, relatedTableData),
      child: BlocBuilder<CorrelatedDataBlocBloc, CorrelatedDataBlocState>(
          builder: (context, state) {
        return Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 6,
                child: PaginatedTableWidget(
                  title: state.mainRawData.title,
                  dataSource: DataSource(context, state.mainRawData),
                ),
              ),
              Flexible(
                flex: 6,
                child: PaginatedTableWidget(
                    title: state.dependedRawDate.title,
                    dataSource: DataSource(context, state.dependedRawDate),
                    filter: (rowsData) {
                      return rowsData.any(
                          (element) => element.id == state.selectedEntity!.id);
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}

part of 'single_paginated_table_bloc.dart';

abstract class SinglePaginatedTableState extends Equatable {
  final BuildContext context;
  final List<TablableEntity> tableDataRawList;
  const SinglePaginatedTableState(this.context,
      {required this.tableDataRawList});

  @override
  List<Object> get props => tableDataRawList;
}

class SinglePaginatedTableBlocInitial extends SinglePaginatedTableState {
  SinglePaginatedTableBlocInitial(super.context)
      : super(tableDataRawList: const []) {
    BlocProvider.of<SinglePaginatedTableBloc>(context)
        .add(GetTableDataRawEvent());
  }
}

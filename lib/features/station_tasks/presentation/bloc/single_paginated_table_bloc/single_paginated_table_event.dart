part of 'single_paginated_table_bloc.dart';

abstract class SinglePaginatedTableEvent extends Equatable {
  const SinglePaginatedTableEvent();

  @override
  List<Object> get props => [];
}

class GetTableDataRawEvent extends SinglePaginatedTableEvent {}

class DataLoadedEvent extends SinglePaginatedTableEvent {}

import '/core/entities/tablable_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'single_paginated_table_event.dart';
part 'single_paginated_table_state.dart';

class SinglePaginatedTableBloc
    extends Bloc<SinglePaginatedTableEvent, SinglePaginatedTableState> {
  BuildContext context;
  // final UseCase<TablableEntity, Params<dynamic>> useCase;
  SinglePaginatedTableBloc(this.context)
      : super(SinglePaginatedTableBlocInitial(context)) {
    on<GetTableDataRawEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

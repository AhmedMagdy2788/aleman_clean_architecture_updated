import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'row_tables_event.dart';
part 'row_tables_state.dart';

class RowTablesBloc extends Bloc<RowTablesEvent, RowTablesState> {
  RowTablesBloc() : super(RowTablesInitial()) {
    on<RowTablesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

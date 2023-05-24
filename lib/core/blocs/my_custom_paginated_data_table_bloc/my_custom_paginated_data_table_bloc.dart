import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_custom_paginated_data_table_event.dart';
part 'my_custom_paginated_data_table_state.dart';

class MyCustomPaginatedDataTableBlocBloc extends Bloc<
    MyCusotmerPaginatedDataTableBlocEvent,
    MyCusotmerPaginatedDataTableBlocState> {
  MyCustomPaginatedDataTableBlocBloc()
      : super(MyCusotmerPaginatedDataTableBlocInitial()) {
    on<MyCusotmerPaginatedDataTableBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import '/core/entities/tablable_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'correlated_data_bloc_event.dart';
part 'correlated_data_bloc_state.dart';

class CorrelatedDataBlocBloc<T, R>
    extends Bloc<CorrelatedDataBlocEvent, CorrelatedDataBlocState<T, R>> {
  CorrelatedDataBlocBloc(
      TableDataSource<T> mainTableData, TableDataSource<R> relatedTableData)
      : super(CorrelatedDataBlocInitial(
            mainRawData: mainTableData, dependedRawDate: relatedTableData)) {
    on<CorrelatedDataBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

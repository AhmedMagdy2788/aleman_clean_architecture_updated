part of 'correlated_data_bloc_bloc.dart';

abstract class CorrelatedDataBlocState<T, R> extends Equatable {
  final TableDataSource<T> mainRawData;
  final TableDataSource<R> dependedRawDate;
  final TablableEntity? selectedEntity;
  const CorrelatedDataBlocState(
      {required this.mainRawData,
      required this.dependedRawDate,
      this.selectedEntity});

  @override
  List<Object?> get props => [mainRawData, dependedRawDate, selectedEntity];
}

class CorrelatedDataBlocInitial<T, R> extends CorrelatedDataBlocState<T, R> {
  const CorrelatedDataBlocInitial(
      {required super.mainRawData, required super.dependedRawDate});
}

class SelectedEntityState<T, R> extends CorrelatedDataBlocState<T, R> {
  const SelectedEntityState(
      {required super.selectedEntity,
      required super.mainRawData,
      required super.dependedRawDate});
}

import 'dart:developer';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/use_cases.dart';
import '../../../../../core/widgets/group_icon_settings.dart';
import '../../../domain/entities/station_entity.dart';
import '../../../domain/entities/subcompany_entity.dart';
import '../../../domain/usecases/get_stations_of_company_usecase.dart';
import '../../../domain/usecases/get_subcompanies_usecase.dart';
import '../../pages/station_page.dart';
import '../../widgets/date_picker_widget.dart';
import '../../widgets/message_disply_widget.dart';
import '../../widgets/subcompnies_stations_subpages.dart';

part 'stations_of_companies_event.dart';
part 'stations_of_companies_state.dart';

class StationsOfCompaniesBloc
    extends Bloc<StationsOfCompaniesEvent, StationsOfCompaniesState> {
  GetStationOfCompanyUseCase getStationOfCompanyUseCase;
  GetSubCompaniesUseCase getSubCompaniesUseCase;

  StationsOfCompaniesBloc({
    required this.getSubCompaniesUseCase,
    required this.getStationOfCompanyUseCase,
  }) : super(LoadingSubcompaniesListState(date: DateTime.now())) {
    on<GetSubCompaniesListEvent>((event, emit) async {
      emit(await getSubCompaniesListState(event));
    });

    on<SelectSubCompanyEvent>((event, emit) async {
      emit(LoadingStationsState.copyWith(
        prevState: state,
        selectedSubcompany: event.selectedSubcompany,
      ));
    });

    on<GetStationsListEvent>((event, emit) async {
      emit(await getStationsListState(event));
    });

    on<SelectStatonEvent>((event, emit) async {
      emit(SelectedStationState.copyWith(
        selectedStation: event.stationEntity,
        prevState: state,
      ));
    });

    on<ChangeDateEvent>((event, emit) async {
      emit(SelectedDateState.copyWith(date: event.date, prevState: state));
    });
  }

  Future<StationsOfCompaniesState> getSubCompaniesListState(
      GetSubCompaniesListEvent event) async {
    var either = await getSubCompaniesUseCase.call(NoParams());
    return either.fold<Future<StationsOfCompaniesState>>(
        (l) async => ErrorState.copyWith(message: l.message, prevState: state),
        (r) async => LoadedSubCompnaieslistState.copyWith(
            subCompaniesList: r, prevState: state));
  }

  Future<StationsOfCompaniesState> getStationsListState(
      GetStationsListEvent event) async {
    var either = await getStationOfCompanyUseCase
        .call(Params(state.selectedSubcompany!.name));
    return either.fold<Future<StationsOfCompaniesState>>(
        (l) async => ErrorState.copyWith(message: l.message, prevState: state),
        (r) async => LoadedStationsListState.copyWith(
              prevState: state,
              stationsList: r,
            ));
  }
}

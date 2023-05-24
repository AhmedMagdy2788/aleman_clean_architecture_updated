import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/dark_theme_usecase.dart';
import '../../domain/usecases/light_theme_usecase.dart';

part 'app_themes_event.dart';
part 'app_themes_state.dart';

class AppThemesBloc extends Bloc<AppThemesEvent, AppThemesState> {
  final GetDarkThemeUseCase getDarkThemeUseCase;
  final GetLightThemeUseCase getLightThemeUseCase;
  AppThemesBloc(
      {required this.getDarkThemeUseCase, required this.getLightThemeUseCase})
      : super(const AppThemesInitialState()) {
    on<AppThemesEvent>((event, emit) {
      if (event is SwitchToSystemThemeEvent) {
        emit(const AppThemesInitialState());
      }
      if (event is SwitchToDarkModeEvent) emit(const DarkAppThemeState());
      if (event is SwitchToLightModeEvent) emit(const LightAppThemeState());
    });
  }
}

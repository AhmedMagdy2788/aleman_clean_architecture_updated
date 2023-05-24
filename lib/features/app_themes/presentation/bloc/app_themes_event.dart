part of 'app_themes_bloc.dart';

abstract class AppThemesEvent extends Equatable {
  const AppThemesEvent();

  @override
  List<Object> get props => [];
}

class SwitchToSystemThemeEvent extends AppThemesEvent {}

class SwitchToDarkModeEvent extends AppThemesEvent {}

class SwitchToLightModeEvent extends AppThemesEvent {}

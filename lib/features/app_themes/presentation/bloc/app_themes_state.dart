part of 'app_themes_bloc.dart';

abstract class AppThemesState extends Equatable {
  final List<Object?> _list;
  const AppThemesState(this._list);

  @override
  List<Object?> get props => _list;
}

class AppThemesInitialState extends AppThemesState {
  const AppThemesInitialState() : super(const [ThemeMode.system]);
}

class DarkAppThemeState extends AppThemesState {
  const DarkAppThemeState() : super(const [ThemeMode.dark]);
}

class LightAppThemeState extends AppThemesState {
  const LightAppThemeState() : super(const [ThemeMode.light]);
}

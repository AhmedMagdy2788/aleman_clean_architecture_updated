import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import 'features/app_themes/presentation/bloc/app_themes_bloc.dart';
import 'features/station_tasks/presentation/pages/logen_page.dart';
import 'features/station_tasks/presentation/pages/main_page.dart';
import 'injection.dart' as di;
import 'injection.dart';
import 'features/app_themes/data/models/app_theme.dart';

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  List<String> listOfLangs = ['ar', 'en'];
  String langDir = 'assets/lang/';
  await translator.init(
    languagesList: listOfLangs,
    localeType: LocalizationDefaultType.device,
    assetsDirectory: langDir,
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(600, 800));
  }

  runApp(LocalizedApp(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [BlocProvider<AppThemesBloc>(create: (ctx) => sl())],
      child: BlocBuilder<AppThemesBloc, AppThemesState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Aleman Group',
            themeMode: state.props[0] as ThemeMode,
            theme: AppTheme.appThemeLight(),
            darkTheme: AppTheme.appThemeDark(),
            scrollBehavior: const ScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.trackpad,
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            home:
                // const LoginWidget(),
                const MainPage(),
            // const MyHomePage(),
          );
        },
      ),
    );
  }
}

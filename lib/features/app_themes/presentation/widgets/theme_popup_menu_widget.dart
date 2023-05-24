import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_themes_bloc.dart';

class ThemePopupMenuWidget extends StatelessWidget {
  const ThemePopupMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemesBloc, AppThemesState>(
        builder: (context, state) {
      return PopupMenuButton(
        child: const Icon(Icons.mode_night_outlined),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text("System Theme"),
            onTap: () {
              BlocProvider.of<AppThemesBloc>(context)
                  .add(SwitchToSystemThemeEvent());
            },
          ),
          PopupMenuItem(
            child: const Text("Dark Theme"),
            onTap: () {
              BlocProvider.of<AppThemesBloc>(context)
                  .add(SwitchToDarkModeEvent());
            },
          ),
          PopupMenuItem(
            child: const Text("Light Theme"),
            onTap: () {
              BlocProvider.of<AppThemesBloc>(context)
                  .add(SwitchToLightModeEvent());
            },
          ),
        ],
      );
    });
  }
}

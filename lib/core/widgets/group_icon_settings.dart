import 'package:flutter/material.dart';

import '../../features/app_themes/presentation/widgets/theme_popup_menu_widget.dart';

class IconsGroupWidget extends StatelessWidget {
  const IconsGroupWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const ThemePopupMenuWidget(),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';
import '../../domain/entities/station_entity.dart';
import '../bloc/station_tasks_bloc.dart';
import '../widgets/stations/body.dart';
import '../widgets/stations/sidebar.dart';

class StationPage extends InheritedWidget {
  final DateTime initDate;
  final StationEntity station;
  const StationPage({
    super.key,
    required this.station,
    required this.initDate,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant StationPage oldWidget) {
    return station != oldWidget.station;
  }

  static StationPage? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StationPage>();
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationTasksBloc>(
      create: (context) => sl(),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SideNavigationRail(),
            Sidebar(),
            Body(),
          ],
        ),
      ),
    );
  }
}

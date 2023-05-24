// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/station_tasks_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  /*
   * This method is called often (think fps + render). It is a required, 
   * @override and must return a Widget.

   * Remember that in Flutter all gui is a widget with a child or children, 
   * even 'Padding', 'Center'.
   */
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationTasksBloc, StationTasksState>(
        builder: (context, state) {
      return state.buildBodyPage(context);
    });
  }
}

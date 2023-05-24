import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stations_subcompanies_bloc/stations_of_companies_bloc.dart';
import '../../../../core/widgets/group_icon_settings.dart';
import '../../../../injection.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aleman Group"),
        actions: const [IconsGroupWidget(), SizedBox(width: 50)],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocProvider<StationsOfCompaniesBloc>(
      create: (context) => sl(),
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<StationsOfCompaniesBloc,
                  StationsOfCompaniesState>(
                // listenWhen: (prev, current) {
                //   return (prev is LoadedStationsListState &&
                //           current is LoadedStationsListState)
                //       ? true
                //       : false;
                // },
                listener: (context, state) {
                  state.notifyListener(context);
                },
                child: BlocBuilder<StationsOfCompaniesBloc,
                    StationsOfCompaniesState>(
                  builder: (context, state) {
                    return state.buildStateWidget(context);
                  },
                ),
              )),
        ),
      ),
    );
  }
}

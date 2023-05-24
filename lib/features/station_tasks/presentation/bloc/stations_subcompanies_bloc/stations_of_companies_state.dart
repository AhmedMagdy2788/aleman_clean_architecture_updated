part of 'stations_of_companies_bloc.dart';

abstract class StationsOfCompaniesState extends Equatable {
  final DateTime date;
  final SubCompanyEntity? selectedSubcompany;
  final StationEntity? selectedStation;
  final List<SubCompanyEntity>? subCompaniesList;
  final List<StationEntity>? stationsList;
  const StationsOfCompaniesState({
    required this.date,
    this.selectedSubcompany,
    this.selectedStation,
    this.subCompaniesList,
    this.stationsList,
  });

  @override
  List<Object?> get props => [
        date,
        selectedSubcompany,
        selectedStation,
        subCompaniesList,
        stationsList,
      ];

  Widget buildStateWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: buildDatePickerWidget(context, date),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: buildFieldsWidget(context),
            ),
          ],
        ),
        buildActionButton(context, date, selectedStation),
      ],
    );
  }

  Widget buildDatePickerWidget(BuildContext context, DateTime date);

  Widget buildFieldsWidget(BuildContext context);

  Widget buildActionButton(
      BuildContext context, DateTime date, StationEntity? selectedStation);

  void notifyListener(BuildContext context) {}
}

//* initial State *//
class LoadingSubcompaniesListState extends StationsOfCompaniesState {
  const LoadingSubcompaniesListState({required super.date});

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) {
    return DatePickerWidget(
        initDate: date,
        updateDate: (selectedDate) {
          BlocProvider.of<StationsOfCompaniesBloc>(context).add(ChangeDateEvent(
            date: selectedDate,
          ));
          log("date changes to ${selectedDate.formatted}");
        });
  }

  @override
  Widget buildFieldsWidget(BuildContext context) {
    BlocProvider.of<StationsOfCompaniesBloc>(context)
        .add(GetSubCompaniesListEvent(context));
    return const CircularProgressIndicator();
  }

  @override
  Widget buildActionButton(
      BuildContext context, DateTime date, StationEntity? selectedStation) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 600),
            content: Text("Selecte Station First")));
      },
      child: const Text("Show Station"),
    );
  }
}

class LoadedSubCompnaieslistState extends StationsOfCompaniesState {
  final StationsOfCompaniesState prevState;
  LoadedSubCompnaieslistState.copyWith(
      {required super.subCompaniesList, required this.prevState})
      : super(
          date: prevState.date,
          selectedStation: prevState.selectedStation,
          selectedSubcompany: prevState.selectedSubcompany,
          stationsList: prevState.stationsList,
        );

  @override
  Widget buildFieldsWidget(BuildContext context) {
    return LoadedSubCompaniesSubPage(
      subCompaniesList: subCompaniesList!,
    );
  }

  @override
  Widget buildActionButton(BuildContext context, DateTime date,
          StationEntity? selectedStation) =>
      prevState.buildActionButton(context, date, selectedStation);

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) =>
      prevState.buildDatePickerWidget(context, date);
}

class LoadingStationsState extends StationsOfCompaniesState {
  final StationsOfCompaniesState prevState;

  LoadingStationsState.copyWith({
    required super.selectedSubcompany,
    required this.prevState,
  }) : super(
          date: prevState.date,
          selectedStation: null,
          stationsList: prevState.stationsList,
          subCompaniesList: prevState.subCompaniesList,
        );

  @override
  Widget buildFieldsWidget(BuildContext context) {
    BlocProvider.of<StationsOfCompaniesBloc>(context)
        .add(const GetStationsListEvent());
    return const CircularProgressIndicator();
  }

  @override
  Widget buildActionButton(
      BuildContext context, DateTime date, StationEntity? selectedStation) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 600),
            content: Text("Selecte Station First")));
      },
      child: const Text("Show Station"),
    );
  }

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) =>
      prevState.buildDatePickerWidget(context, date);
}

class LoadedStationsListState extends StationsOfCompaniesState {
  final StationsOfCompaniesState prevState;

  LoadedStationsListState.copyWith(
      {required super.stationsList, required this.prevState})
      : super(
          date: prevState.date,
          selectedStation: prevState.selectedStation,
          selectedSubcompany: prevState.selectedSubcompany,
          subCompaniesList: prevState.subCompaniesList,
        );

  @override
  Widget buildFieldsWidget(BuildContext context) {
    return LoadedStationSubPage(
      selectedSubcompny: selectedSubcompany!,
      subCompaniesList: subCompaniesList!,
      stationsList: stationsList!,
    );
  }

  @override
  Widget buildActionButton(BuildContext context, DateTime date,
          StationEntity? selectedStation) =>
      prevState.buildActionButton(context, date, selectedStation);

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) =>
      prevState.buildDatePickerWidget(context, date);

  @override
  void notifyListener(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 2000),
        content: Text("statoinos reloaded...")));
  }
}

class SelectedStationState extends StationsOfCompaniesState {
  final StationsOfCompaniesState prevState;

  SelectedStationState.copyWith(
      {required super.selectedStation, required this.prevState})
      : super(
          date: prevState.date,
          selectedSubcompany: prevState.selectedSubcompany,
          stationsList: prevState.stationsList,
          subCompaniesList: prevState.subCompaniesList,
        );

  @override
  Widget buildFieldsWidget(BuildContext context) {
    return LoadedStationSubPage(
      selectedSubcompny: selectedSubcompany!,
      subCompaniesList: subCompaniesList!,
      stationsList: stationsList!,
      selectedStation: selectedStation,
    );
  }

  @override
  Widget buildActionButton(
      BuildContext context, DateTime date, StationEntity? selectedStation) {
    return ElevatedButton(
      onPressed: () {
        log('navigating with date at ${date.toIso8601String()}');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    selectedStation!.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    selectedStation.partner!,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              actions: const [IconsGroupWidget()],
            ),
            body: StationPage(
              initDate: date,
              station: selectedStation,
              child: const MainLayout(),
            ),
          ),
        ));
      },
      child: const Text("Show Station"),
    );
  }

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) =>
      prevState.buildDatePickerWidget(context, date);

  @override
  void notifyListener(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: Text("station ${selectedStation!.name} selected...")));
  }
}

class SelectedDateState extends StationsOfCompaniesState {
  final StationsOfCompaniesState prevState;

  SelectedDateState.copyWith({
    required super.date,
    required this.prevState,
  }) : super(
          selectedStation: prevState.selectedStation,
          stationsList: prevState.stationsList,
          subCompaniesList: prevState.subCompaniesList,
          selectedSubcompany: prevState.selectedSubcompany,
        );

  @override
  Widget buildActionButton(BuildContext context, DateTime date,
          StationEntity? selectedStation) =>
      prevState.buildActionButton(context, date, selectedStation);

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) =>
      prevState.buildDatePickerWidget(context, date);

  @override
  Widget buildFieldsWidget(BuildContext context) =>
      prevState.buildFieldsWidget(context);
}

class ErrorState extends StationsOfCompaniesState {
  final String message;
  final StationsOfCompaniesState prevState;

  ErrorState.copyWith({required this.message, required this.prevState})
      : super(
          date: prevState.date,
          selectedStation: prevState.selectedStation,
          selectedSubcompany: prevState.selectedSubcompany,
          stationsList: prevState.stationsList,
          subCompaniesList: prevState.subCompaniesList,
        );

  @override
  Widget buildFieldsWidget(BuildContext context) {
    return MessageDisplayWidget(message: message);
  }

  @override
  Widget buildActionButton(BuildContext context, DateTime date,
          StationEntity? selectedStation) =>
      prevState.buildActionButton(context, date, selectedStation);

  @override
  Widget buildDatePickerWidget(BuildContext context, DateTime date) =>
      prevState.buildDatePickerWidget(context, date);

  @override
  void notifyListener(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 600),
      content: Text(message),
    ));
  }
}

part of 'stations_of_companies_bloc.dart';

abstract class StationsOfCompaniesEvent extends Equatable {
  final List<Object> _list;
  const StationsOfCompaniesEvent(this._list);

  @override
  List<Object> get props => _list;
}

class GetSubCompaniesListEvent extends StationsOfCompaniesEvent {
  const GetSubCompaniesListEvent(BuildContext context) : super(const []);
}

class SelectSubCompanyEvent extends StationsOfCompaniesEvent {
  final SubCompanyEntity selectedSubcompany;
  SelectSubCompanyEvent({
    required this.selectedSubcompany,
  }) : super([selectedSubcompany]);
}

class GetStationsListEvent extends StationsOfCompaniesEvent {
  const GetStationsListEvent() : super(const []);
}

class SelectStatonEvent extends StationsOfCompaniesEvent {
  final StationEntity stationEntity;
  SelectStatonEvent({
    required this.stationEntity,
  }) : super([stationEntity]);
}

class ChangeDateEvent extends StationsOfCompaniesEvent {
  final DateTime date;
  ChangeDateEvent({
    required this.date,
  }) : super([date]);
}

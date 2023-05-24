import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/station_entity.dart';
import '../../domain/entities/subcompany_entity.dart';
import 'loaded_dropdown_widgets.dart';

class LoadedSubCompaniesSubPage extends StatelessWidget {
  final List<SubCompanyEntity> subCompaniesList;
  const LoadedSubCompaniesSubPage({required this.subCompaniesList, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LoadedSubCompaniesDropdownWidget(subCompaniesList: subCompaniesList),
        const SizedBox(width: 20),
        Expanded(
          child: DropdownSearch<int>(
            enabled: false,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Choose SubCompany first",
                hintText: "Select an Int",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoadedStationSubPage extends StatelessWidget {
  final SubCompanyEntity selectedSubcompny;
  final StationEntity? selectedStation;
  final List<SubCompanyEntity> subCompaniesList;
  final List<StationEntity> stationsList;
  const LoadedStationSubPage(
      {super.key,
      required this.selectedSubcompny,
      required this.subCompaniesList,
      required this.stationsList,
      this.selectedStation});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LoadedSubCompaniesDropdownWidget(
            initSubcompany: selectedSubcompny,
            subCompaniesList: subCompaniesList),
        const SizedBox(width: 20),
        LoadedStationsDropdownWidget(
          key: UniqueKey(),
          stationsList: stationsList,
          selectedSubcompany: selectedSubcompny,
          subCompaniesList: subCompaniesList,
          selectedStation: selectedStation,
        ),
      ],
    );
  }
}

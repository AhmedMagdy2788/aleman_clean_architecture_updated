import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/station_entity.dart';
import '../../domain/entities/subcompany_entity.dart';
import '../bloc/stations_subcompanies_bloc/stations_of_companies_bloc.dart';

class LoadedSubCompaniesDropdownWidget extends StatelessWidget {
  final SubCompanyEntity? initSubcompany;
  final List<SubCompanyEntity> subCompaniesList;
  const LoadedSubCompaniesDropdownWidget(
      {super.key, required this.subCompaniesList, this.initSubcompany});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownSearch<SubCompanyEntity>(
        // asyncItems: (filter) => getData(context, filter),
        selectedItem: initSubcompany,
        items: subCompaniesList,
        itemAsString: (item) => item.name,
        compareFn: (i, s) => i == s,
        onChanged: (subCompany) {
          if (subCompany != null) {
            log("subcompnies changed to ${subCompany.name}");
            BlocProvider.of<StationsOfCompaniesBloc>(context)
                .add(SelectSubCompanyEvent(
              selectedSubcompany: subCompany,
            ));
          }
        },
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "SubCompany",
            hintText: "Select Subcompany",
          ),
        ),
        popupProps: PopupPropsMultiSelection.menu(
          isFilterOnline: true,
          showSelectedItems: true,
          showSearchBox: true,
          itemBuilder: _subComapnyPopupItemBuilder,
          favoriteItemProps: FavoriteItemProps(
            showFavoriteItems: true,
            favoriteItems: (us) {
              return us.where((e) => e.name.contains("الايمان")).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _subComapnyPopupItemBuilder(
    BuildContext context,
    SubCompanyEntity? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.email ?? ''),
        leading: const CircleAvatar(
            // this does not work - throws 404 error
            // backgroundImage: NetworkImage(item.avatar ?? ''),
            ),
      ),
    );
  }
}

class LoadedStationsDropdownWidget extends StatelessWidget {
  final SubCompanyEntity selectedSubcompany;
  final StationEntity? selectedStation;
  final List<SubCompanyEntity> subCompaniesList;
  final List<StationEntity> stationsList;
  const LoadedStationsDropdownWidget({
    required super.key,
    required this.stationsList,
    required this.selectedSubcompany,
    required this.subCompaniesList,
    this.selectedStation,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownSearch<StationEntity>(
        // asyncItems: (filter) => getData(context, filter),
        selectedItem: selectedStation,
        items: stationsList,
        itemAsString: (item) => item.name,
        compareFn: (i, s) => i == s,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Station",
            hintText: "Select Station",
          ),
        ),
        onChanged: (station) {
          if (station != null) {
            log("station changed to ${station.name}");
            BlocProvider.of<StationsOfCompaniesBloc>(context)
                .add(SelectStatonEvent(
              stationEntity: station,
            ));
          }
        },
        popupProps: PopupPropsMultiSelection.menu(
          isFilterOnline: true,
          showSelectedItems: true,
          showSearchBox: true,
          itemBuilder: _stationPopupItemBuilder,
          fit: FlexFit.loose,
          // title: const Text('fit to a specific max height'),
          constraints: const BoxConstraints(maxHeight: 300),
          favoriteItemProps: FavoriteItemProps(
            showFavoriteItems: true,
            favoriteItems: (us) {
              return us.where((e) => e.name.contains("الودي")).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _stationPopupItemBuilder(
    BuildContext context,
    StationEntity? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.partner ?? ''),
        leading: const CircleAvatar(
            // this does not work - throws 404 error
            // backgroundImage: NetworkImage(item.avatar ?? ''),
            ),
      ),
    );
  }
}

// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

class StationEntity extends Equatable {
  static const String ID = "id";
  static const String NAME = "Station Name";
  static const String OWNER_COMPANY = "Owner Company";
  static const String LOCATION = "Location";
  static const String PARTNER = "Partner Ship";

  final int id;
  final String name;
  final String ownerCompany;
  final String location;
  final String? partner;

  const StationEntity({
    required this.id,
    required this.name,
    required this.ownerCompany,
    required this.location,
    this.partner,
  }) : super();

  @override
  List<Object?> get props => [id, name, ownerCompany, location, partner];
}

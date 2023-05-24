// ignore_for_file: constant_identifier_names
import 'package:equatable/equatable.dart';

class SubCompanyEntity extends Equatable {
  final String name;
  final String address;
  final String taxCard;
  final String commercialRegistration;
  final String? fax;
  final String? email;

  const SubCompanyEntity(
      {required this.name,
      required this.address,
      required this.taxCard,
      required this.commercialRegistration,
      this.fax,
      this.email});
  @override
  List<Object?> get props =>
      [name, address, taxCard, commercialRegistration, fax, email];
}

class CompanyDriverEntity extends Equatable {
  final int id;
  final String driverName;
  final int? licenseNo;

  const CompanyDriverEntity(
      {required this.id, required this.driverName, required this.licenseNo});

  @override
  List<Object?> get props => [id, driverName, licenseNo];
}

class CompanyTruckEntity extends Equatable {
  final int id;
  final String companyTruckNo;
  final String model;
  final int? truckLoad;

  const CompanyTruckEntity(
      {required this.id,
      required this.companyTruckNo,
      required this.model,
      required this.truckLoad});

  @override
  List<Object?> get props => [id, companyTruckNo, model, truckLoad];
}

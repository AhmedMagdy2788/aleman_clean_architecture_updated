// ignore_for_file: constant_identifier_names
import 'package:equatable/equatable.dart';

class MarketingComapnyEntity extends Equatable {
  final String name;
  final String? address;
  final String? phone;
  final String? email;
  final String? fax;

  const MarketingComapnyEntity({
    required this.name,
    this.address,
    this.phone,
    this.email,
    this.fax,
  });

  @override
  List<Object?> get props => [name, address, phone, email, fax];
}

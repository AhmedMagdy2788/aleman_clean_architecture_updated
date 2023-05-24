// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int id;
  final String name;
  final String? address;
  final int? phone;
  final String? guarantor;

  const CustomerEntity({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.guarantor,
  });

  @override
  List<Object?> get props => [id, name, address, phone, guarantor];
}

// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

class CustomerTruckEntity extends Equatable {
  final int customerId;
  final String name;
  final String truckNo;
  const CustomerTruckEntity({
    required this.customerId,
    required this.name,
    required this.truckNo,
  });

  @override
  List<Object?> get props => [customerId, name, truckNo];
}

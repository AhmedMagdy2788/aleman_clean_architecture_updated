// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

enum Authentication {
  readData,
  writeData,
  editData,
  removeData,
  stationsAccess,
  transportationAccess,
}

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String password;
  final String profession;
  final String? imageLink;
  final List<Authentication>? authList;

  const UserEntity({
    required this.id,
    required this.name,
    required this.password,
    required this.profession,
    this.imageLink,
    this.authList,
  });

  @override
  List<Object?> get props =>
      [id, name, password, profession, imageLink, authList];
}

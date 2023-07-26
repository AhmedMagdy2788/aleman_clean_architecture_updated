// ignore_for_file: constant_identifier_names
import '../../../../../core/models/server_model.dart';
import '../../../domain/entities/user_entity.dart';

enum Authentication {
  readData,
  writeData,
  editData,
  removeData,
  stationsAccess,
  transportationAccess,
}

class UserServerModel extends UserEntity implements ServerModel {
  static const String TABLENAME = 'Tblusers';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PASSWORD = 'password';
  static const String PROFESSION = 'profession';
  static const String IMAGELINK = 'imageLink';
  static const String AUTHLIST = 'authList';

  const UserServerModel({
    required super.id,
    required super.name,
    required super.password,
    required super.profession,
    super.imageLink,
    super.authList,
  });

  factory UserServerModel.fromJson(Map<String, dynamic> json) {
    return UserServerModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      profession: json['profession'],
      imageLink: json['imageLink'],
      authList: json['authList'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NAME: name,
      PASSWORD: password,
      PROFESSION: profession,
      IMAGELINK: imageLink,
      AUTHLIST: authList,
    };
  }
}

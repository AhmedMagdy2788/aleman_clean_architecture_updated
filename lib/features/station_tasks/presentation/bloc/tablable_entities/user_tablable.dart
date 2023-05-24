// ignore_for_file: constant_identifier_names
import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/user_entity.dart';

class UserTableDataSouce extends TableDataSource<UserEntity> {
  UserTableDataSouce(List<UserEntity> equatableDataList)
      : super(dataList: [], title: "Users") {
    for (var element in equatableDataList) {
      super.dataList.add(UserTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns['id'] = String;
    columns['name'] = String;
    columns['password'] = String;
    columns['profession'] = String;
    columns['imageLink'] = String;
    return columns;
  }
}

class UserTablable extends TablableEntity<UserEntity> {
  static const String ID = 'ID';
  static const String NAME = 'Name';
  static const String PASSWORD = 'Password';
  static const String PROFESSION = 'Profession';
  static const String IMAGELINK = 'ImageLink';
  static const String AUTHLIST = 'AuthList';

  UserTablable(UserEntity userEntity) : super(userEntity);

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: entity.id,
      NAME: entity.name,
      PASSWORD: entity.password,
      PROFESSION: entity.profession,
      IMAGELINK: entity.imageLink,
      AUTHLIST: entity.authList,
    };
  }

  @override
  get id => entity.id;
}

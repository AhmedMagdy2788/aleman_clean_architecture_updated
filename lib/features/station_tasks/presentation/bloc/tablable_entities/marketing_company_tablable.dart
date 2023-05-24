// ignore_for_file: constant_identifier_names

import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/marketing_company_entity.dart';

class MarketingComapnyTableDataSouce
    extends TableDataSource<MarketingComapnyEntity> {
  MarketingComapnyTableDataSouce(List<MarketingComapnyEntity> equatableDataList)
      : super(dataList: [], title: "Marketing Compnaies") {
    for (var element in equatableDataList) {
      super.dataList.add(MarketingComapnyTablable(element));
    }
  }
  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[MarketingComapnyTablable.NAME] = String;
    columns[MarketingComapnyTablable.ADDRESS] = String;
    columns[MarketingComapnyTablable.PHONE] = String;
    columns[MarketingComapnyTablable.EMAIL] = String;
    columns[MarketingComapnyTablable.FAX] = String;
    return columns;
  }
}

class MarketingComapnyTablable extends TablableEntity<MarketingComapnyEntity> {
  static const String NAME = "Name";
  static const String ADDRESS = "Address";
  static const String PHONE = "Phone";
  static const String EMAIL = "Email";
  static const String FAX = "Fax";

  MarketingComapnyTablable(MarketingComapnyEntity marketingComapnyEntity)
      : super(marketingComapnyEntity);

  @override
  String get id => entity.name;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      NAME: entity.name,
      ADDRESS: entity.address,
      PHONE: entity.phone,
      EMAIL: entity.email,
      FAX: entity.fax,
    };
  }
}

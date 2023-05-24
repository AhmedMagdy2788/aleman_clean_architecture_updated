// ignore_for_file: constant_identifier_names

import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/customer_entity.dart';

class CustomerTableDataSouce extends TableDataSource<CustomerEntity> {
  CustomerTableDataSouce(List<CustomerEntity> equatableDataList)
      : super(dataList: [], title: "Station Customers") {
    for (var element in equatableDataList) {
      super.dataList.add(CustomerTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[CustomerTablable.ID] = int;
    columns[CustomerTablable.NAME] = String;
    columns[CustomerTablable.ADDRESS] = String;
    columns[CustomerTablable.PHONE] = int;
    columns[CustomerTablable.GUARANTOR] = String;
    return columns;
  }
}

class CustomerTablable extends TablableEntity<CustomerEntity> {
  static const String ID = "ID";
  static const String NAME = "Name";
  static const String ADDRESS = "Address";
  static const String PHONE = "Phone";
  static const String GUARANTOR = "Guarantor";

  CustomerTablable(CustomerEntity customer) : super(customer);

  @override
  get id => entity.id;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: entity.id,
      NAME: entity.name,
      ADDRESS: entity.address,
      PHONE: entity.phone,
      GUARANTOR: entity.guarantor,
    };
  }
}

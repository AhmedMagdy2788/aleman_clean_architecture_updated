// ignore_for_file: constant_identifier_names

import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/subcompany_entity.dart';

class SubCompanyTableDataSouce extends TableDataSource<SubCompanyEntity> {
  SubCompanyTableDataSouce(List<SubCompanyEntity> equatableDataList)
      : super(dataList: [], title: "SubCompanies") {
    for (var element in equatableDataList) {
      super.dataList.add(SubCompanyTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[SubCompanyTablable.NAME] = String;
    columns[SubCompanyTablable.ADDRESS] = String;
    columns[SubCompanyTablable.TAX_CARD] = String;
    columns[SubCompanyTablable.COMMERCIAL_REGISTRATION] = String;
    columns[SubCompanyTablable.FAX] = String;
    columns[SubCompanyTablable.EMAIL] = String;
    return columns;
  }
}

class SubCompanyTablable extends TablableEntity<SubCompanyEntity> {
  static const String NAME = "Name";
  static const String ADDRESS = "Address";
  static const String TAX_CARD = "Tax Card";
  static const String COMMERCIAL_REGISTRATION = "Commercial Registration";
  static const String FAX = "Fax";
  static const String EMAIL = "Email";

  SubCompanyTablable(SubCompanyEntity subCompanyEntity)
      : super(subCompanyEntity);

  @override
  String get id => entity.name;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      NAME: entity.name,
      ADDRESS: entity.address,
      TAX_CARD: entity.taxCard,
      COMMERCIAL_REGISTRATION: entity.commercialRegistration,
      FAX: entity.fax,
      EMAIL: entity.email,
    };
  }
}

// Table data source class
class CompanyDriverTableDataSouce extends TableDataSource<CompanyDriverEntity> {
  CompanyDriverTableDataSouce(List<CompanyDriverEntity> equatableDataList)
      : super(dataList: [], title: CompanyDriverTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(CompanyDriverTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[CompanyDriverTablable.ID] = int;
    columns[CompanyDriverTablable.DRIVER_NAME] = String;
    columns[CompanyDriverTablable.LICENSE_NO] = int;
    return columns;
  }
}

// Tablable class
class CompanyDriverTablable extends TablableEntity<CompanyDriverEntity> {
  static const String TABLENAME = 'Company Drivers';
  static const String ID = "ID";
  static const String DRIVER_NAME = "Driver Name";
  static const String LICENSE_NO = "License No";

  CompanyDriverTablable(CompanyDriverEntity driver) : super(driver);

  @override
  get id => entity.id;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: entity.id,
      DRIVER_NAME: entity.driverName,
      LICENSE_NO: entity.licenseNo,
    };
  }
}

// Table data source class
class CompanyTruckTableDataSouce extends TableDataSource<CompanyTruckEntity> {
  CompanyTruckTableDataSouce(List<CompanyTruckEntity> equatableDataList)
      : super(dataList: [], title: CompanyTruckTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(CompanyTruckTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[CompanyTruckTablable.ID] = int;
    columns[CompanyTruckTablable.COMPANY_TRUCK_NO] = String;
    columns[CompanyTruckTablable.MODEL] = String;
    columns[CompanyTruckTablable.TRUCK_LOAD] = int;
    return columns;
  }
}

// Tablable class
class CompanyTruckTablable extends TablableEntity<CompanyTruckEntity> {
  static const String TABLENAME = 'Company Trucks';
  static const String ID = "ID";
  static const String COMPANY_TRUCK_NO = "Company Truck No";
  static const String MODEL = "Model";
  static const String TRUCK_LOAD = "Truck Load";

  CompanyTruckTablable(CompanyTruckEntity truck) : super(truck);

  @override
  get id => entity.id;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: entity.id,
      COMPANY_TRUCK_NO: entity.companyTruckNo,
      MODEL: entity.model,
      TRUCK_LOAD: entity.truckLoad,
    };
  }
}

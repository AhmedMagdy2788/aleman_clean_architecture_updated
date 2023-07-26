// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/tanks_pumps_counters_entity.dart';

///* tanks ///
class TankTableDataSouce extends TableDataSource<TankEntity> {
  TankTableDataSouce(List<TankEntity> equatableDataList)
      : super(dataList: [], title: TankTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(TankTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[TankTablable.ID] = int;
    columns[TankTablable.NAME] = String;
    columns[TankTablable.STATION_NAME] = String;
    columns[TankTablable.CAPACITY] = int;
    return columns;
  }
}

class TankTablable extends TablableEntity<TankEntity> {
  static const String TABLENAME = 'Station Tanks';
  static const String ID = "ID";
  static const String NAME = "Name";
  static const String STATION_NAME = "Station Name";
  static const String CAPACITY = "Max Capacity";

  TankTablable(TankEntity tank) : super(tank);

  @override
  get id => entity.id;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: entity.id,
      NAME: entity.name,
      STATION_NAME: entity.stationName,
      CAPACITY: entity.capacity,
    };
  }
}

///* tanks Products///
class TankProductTableDataSouce extends TableDataSource<TankProductEntity> {
  TankProductTableDataSouce(List<TankProductEntity> equatableDataList)
      : super(dataList: [], title: "Tanks Products") {
    for (var element in equatableDataList) {
      super.dataList.add(TankProductTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[TankProductTablable.PRODUCT] = String;
    return columns;
  }
}

class TankProductTablable extends TablableEntity<TankProductEntity> {
  static const String PRODUCT = "Product";
  TankProductTablable(TankProductEntity tankProduct) : super(tankProduct);
  @override
  String get id => entity.product;

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      PRODUCT: entity.product,
    };
  }
}

///* tanks Content Type ///
class TankContentTypeTableDataSouce
    extends TableDataSource<TankContentTypeEntity> {
  TankContentTypeTableDataSouce(List<TankContentTypeEntity> equatableDataList)
      : super(dataList: [], title: "Tanks Content Type") {
    for (var element in equatableDataList) {
      super.dataList.add(TankContentTypeTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[TankContentTypeTablable.DATE] = DateTime;
    columns[TankContentTypeTablable.TANK_NO] = int;
    columns[TankContentTypeTablable.PRODUCT_NAME] = String;
    return columns;
  }
}

class TankContentTypeTablable extends TablableEntity<TankContentTypeEntity> {
  static const String DATE = "Date";
  static const String TANK_NO = "Tank No";
  static const String PRODUCT_NAME = "Product Name";

  TankContentTypeTablable(TankContentTypeEntity customer) : super(customer);

  @override
  get id => [entity.date, entity.tankNo];

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: DateFormat("yyyy-MM-dd").format(entity.date),
      TANK_NO: entity.tankNo,
      PRODUCT_NAME: entity.productName,
    };
  }
}

///* tanks Daily Measurements ///
class TanksDailyMeasurementTableDataSouce
    extends TableDataSource<TanksDailyMeasurementEntity> {
  TanksDailyMeasurementTableDataSouce(
      List<TanksDailyMeasurementEntity> equatableDataList)
      : super(dataList: [], title: TanksDailyMeasurementTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(TanksDailyMeasurementTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[TanksDailyMeasurementTablable.DATE] = DateTime;
    columns[TanksDailyMeasurementTablable.TANK_NO] = int;
    columns[TanksDailyMeasurementTablable.QUANTITY] = String;
    return columns;
  }
}

class TanksDailyMeasurementTablable
    extends TablableEntity<TanksDailyMeasurementEntity> {
  static const String TABLENAME = 'tblTanksQuantity';
  static const String DATE = "Registeration Date";
  static const String TANK_NO = "Tank No";
  static const String QUANTITY = "Measurement";

  @override
  bool selected = false;

  TanksDailyMeasurementTablable(TanksDailyMeasurementEntity entity)
      : super(entity);

  @override
  Map<int, DateTime> get id => {entity.tankNo: entity.date};

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: entity.date,
      TANK_NO: entity.tankNo,
      QUANTITY: entity.quantity,
    };
  }
}

///* tanks Equilibrium///
class TankEquilibriumTableDataSouce
    extends TableDataSource<TankEquilibriumEntity> {
  TankEquilibriumTableDataSouce(List<TankEquilibriumEntity> equatableDataList)
      : super(dataList: [], title: "Station TankEquilibriums") {
    for (var element in equatableDataList) {
      super.dataList.add(TankEquilibriumTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[TankEquilibriumTablable.DATE] = DateTime;
    columns[TankEquilibriumTablable.STATION_NAME] = String;
    columns[TankEquilibriumTablable.PRODUCT_NAME] = String;
    columns[TankEquilibriumTablable.PRODUCT_NO] = int;
    columns[TankEquilibriumTablable.QUANTITY] = double;
    columns[TankEquilibriumTablable.NOTES] = String;
    return columns;
  }
}

class TankEquilibriumTablable extends TablableEntity<TankEquilibriumEntity> {
  static const String DATE = "Date";
  static const String STATION_NAME = "Station Name";
  static const String PRODUCT_NAME = "Product Name";
  static const String PRODUCT_NO = "Product No";
  static const String QUANTITY = "Quantity";
  static const String NOTES = "Notes";

  TankEquilibriumTablable(TankEquilibriumEntity tankEquilibrium)
      : super(tankEquilibrium);
  @override
  Map<String, dynamic> get id => {
        DATE: entity.date,
        STATION_NAME: entity.stationName,
        PRODUCT_NO: entity.productNo
      };

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: entity.date,
      STATION_NAME: entity.stationName,
      PRODUCT_NAME: entity.productName,
      PRODUCT_NO: entity.productNo,
      QUANTITY: entity.quantity,
      NOTES: entity.notes,
    };
  }
}

///* pumps Tanks Details ////

class PumpTankDetailTablable extends TablableEntity<PumpTankDetailDtoEntity> {
  static const String DATE = "Date";
  static const String PUMP_NO = "Pump No";
  static const String PUMP_NAME = "Pump Name";
  static const String TANK_NO = "Tank No";
  static const String TANK_NAME = "Tank Name";
  static const String TANK_CONTENT_TYPE = "Tank Content Type";

  PumpTankDetailTablable(PumpTankDetailDtoEntity pumpTankDetail)
      : super(pumpTankDetail);

  @override
  get id => [entity.date, entity.pumpNo];

  @override
  bool selected = false;

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: DateFormat("yyyy-MM-dd").format(entity.date),
      PUMP_NO: entity.pumpNo,
      PUMP_NAME: entity.pumpName,
      TANK_NO: entity.tankNo,
      TANK_NAME: entity.tankName,
      TANK_CONTENT_TYPE: entity.tankContentType,
    };
  }
}

class PumpTankDetailTableDataSouce
    extends TableDataSource<PumpTankDetailEntity> {
  PumpTankDetailTableDataSouce(List<PumpTankDetailDtoEntity> equatableDataList)
      : super(dataList: [], title: "Pumps and Tanks Details") {
    for (var element in equatableDataList) {
      super.dataList.add(PumpTankDetailTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[PumpTankDetailTablable.DATE] = DateTime;
    columns[PumpTankDetailTablable.PUMP_NO] = int;
    columns[PumpTankDetailTablable.PUMP_NAME] = String;
    columns[PumpTankDetailTablable.TANK_NO] = int;
    columns[PumpTankDetailTablable.TANK_NAME] = String;
    columns[PumpTankDetailTablable.TANK_CONTENT_TYPE] = String;
    return columns;
  }
}

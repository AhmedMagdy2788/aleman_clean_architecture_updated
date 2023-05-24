// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/tanks_pumps_counters_entity.dart';

class TankJSONModel extends TankEntity implements JSONModel {
  static const String TABLENAME = 'tblTanks';
  static const String ID = "tank_no";
  static const String NAME = "tank_name";
  static const String STATION_NAME = "station_name";
  static const String CAPACITY = "max_capacity";

  const TankJSONModel({
    required super.id,
    required super.name,
    required super.stationName,
    required super.capacity,
  });

  factory TankJSONModel.fromJson(Map<String, dynamic> json) {
    return TankJSONModel(
      id: json[ID],
      name: json[NAME],
      stationName: json[STATION_NAME],
      capacity: json[CAPACITY],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ID: id,
      NAME: name,
      STATION_NAME: stationName,
      CAPACITY: capacity,
    };
  }
}

class TankProductJSONModel extends TankProductEntity implements JSONModel {
  static const String TABLENAME = 'tblPumpType';
  static const String PRODUCT = "tanks_products";

  const TankProductJSONModel({
    required super.product,
  });

  factory TankProductJSONModel.fromJson(Map<String, dynamic> json) {
    return TankProductJSONModel(product: json[PRODUCT]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      PRODUCT: product,
    };
  }
}

class TankContaintTypeJSONModel extends TankContentTypeEntity
    implements JSONModel {
  static const String TABLENAME = 'tblTanksContentsType';
  static const String DATE = "date";
  static const String TANK_NO = "tank_no";
  static const String PRODUCT_NAME = "product";

  const TankContaintTypeJSONModel({
    required super.date,
    required super.tankNo,
    required super.productName,
  });

  factory TankContaintTypeJSONModel.fromJson(Map<String, dynamic> json) {
    return TankContaintTypeJSONModel(
      date: DateFormat("yyyy-MM-dd").parse(json[DATE]),
      tankNo: json[TANK_NO],
      productName: json[PRODUCT_NAME],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: date,
      TANK_NO: tankNo,
      PRODUCT_NAME: productName,
    };
  }
}

class TanksDailyMeasurementJSONModel extends TanksDailyMeasurementEntity
    implements JSONModel {
  static const String TABLENAME = 'tblTanksQuantity';
  static const String DATE = "registeration_date";
  static const String TANK_NO = "tank_no";
  static const String QUANTITY = "tank_stock_measurement";

  const TanksDailyMeasurementJSONModel({
    required super.date,
    required super.tankNo,
    required super.quantity,
  });

  factory TanksDailyMeasurementJSONModel.fromJson(Map<String, dynamic> json) {
    return TanksDailyMeasurementJSONModel(
        date: DateFormat("yyyy-MM-dd").parse(json[DATE]),
        tankNo: json[TANK_NO],
        quantity: json[QUANTITY]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: date,
      TANK_NO: tankNo,
      QUANTITY: quantity,
    };
  }
}

class TankEquilibriumJSONModel extends TankEquilibriumEntity
    implements JSONModel {
  static const String TABLENAME = 'tblTanksEquilibrium';
  static const String DATE = "date";
  static const String STATION_NAME = "station_name";
  static const String PRODUCT_NAME = "product_name";
  static const String PRODUCT_NO = "product_no";
  static const String QUANTITY = "quantity";
  static const String NOTES = "Notes";

  const TankEquilibriumJSONModel({
    required super.date,
    required super.stationName,
    required super.productName,
    required super.productNo,
    required super.quantity,
    super.notes,
  });

  factory TankEquilibriumJSONModel.fromJson(Map<String, dynamic> json) {
    return TankEquilibriumJSONModel(
      date: DateFormat("yyyy-MM-dd").parse(json[DATE]),
      stationName: json[STATION_NAME],
      productName: json[PRODUCT_NAME],
      productNo: json[PRODUCT_NO],
      quantity: json[QUANTITY],
      notes: json[NOTES],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: date,
      STATION_NAME: stationName,
      PRODUCT_NAME: productName,
      PRODUCT_NO: productNo,
      QUANTITY: quantity,
      NOTES: notes,
    };
  }
}

class PumpJSONModel extends PumpEntity implements JSONModel {
  static const String TABLENAME = 'Tblstationspump';
  static const String PUMP_ID = "pump_no";
  static const String PUMP_NAME = "pump_name";

  const PumpJSONModel({required super.pumpId, required super.pumpName});

  factory PumpJSONModel.fromJson(Map<String, dynamic> json) {
    return PumpJSONModel(pumpId: json[PUMP_ID], pumpName: json[PUMP_NAME]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {PUMP_ID: pumpId, PUMP_NAME: pumpName};
  }
}

class PumpOnTankJSONModel extends PumpOnTankEntity implements JSONModel {
  static const String TABLENAME = 'tblpumpstanksdetails';
  static const String WORK_ON_DATE = "date";
  static const String TANK_NO = "tank_no";
  static const String PUMP_ID = "pump_no";

  const PumpOnTankJSONModel({
    required super.workOnDate,
    required super.tankNO,
    required super.pumpId,
  });

  factory PumpOnTankJSONModel.fromJson(Map<String, dynamic> json) {
    return PumpOnTankJSONModel(
      workOnDate: DateFormat("yyyy-MM-dd").parse(json[WORK_ON_DATE]),
      tankNO: json[TANK_NO],
      pumpId: json[PUMP_ID],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      WORK_ON_DATE: workOnDate,
      TANK_NO: tankNO,
      PUMP_ID: pumpId,
    };
  }
}

class CounterJSONModel extends CounterEntity implements JSONModel {
  static const String TABLENAME = 'tblstationscounters';
  static const String COUNTER_ID = "counter_no";
  static const String COUNTER_NAME = "counter_name";

  const CounterJSONModel(
      {required super.counterId, required super.counterName});

  factory CounterJSONModel.fromJson(Map<String, dynamic> json) {
    return CounterJSONModel(
        counterId: json[COUNTER_ID], counterName: json[COUNTER_NAME]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {COUNTER_ID: counterId, COUNTER_NAME: counterName};
  }
}

class CounterOnPumpJSONModel extends CounterOnPumpEntity implements JSONModel {
  static const String TABLENAME = 'tblcounterspumpsdetails';
  static const String WORK_ON_DATE = "date";
  static const String COUNTER_NO = "counter_no";
  static const String PUMP_ID = "pump_no";

  const CounterOnPumpJSONModel({
    required super.workOnDate,
    required super.counterNO,
    required super.pumpId,
  });

  factory CounterOnPumpJSONModel.fromJson(Map<String, dynamic> json) {
    return CounterOnPumpJSONModel(
      workOnDate: DateFormat("yyyy-MM-dd").parse(json[WORK_ON_DATE]),
      counterNO: json[COUNTER_NO],
      pumpId: json[PUMP_ID],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      WORK_ON_DATE: workOnDate,
      COUNTER_NO: counterNO,
      PUMP_ID: pumpId,
    };
  }
}

class CounterFeedbackAmountJSONModel extends CounterFeedbackAmountEntity
    implements JSONModel {
  static const String TABLENAME = 'tblcountersfeedback';
  static const String DATE_OF_CALIBRATION = "date";
  static const String COUNTER_NO = "counter_no";
  static const String FEEDBACK_AMOUNT = "feedback_amount_per_galon";

  const CounterFeedbackAmountJSONModel({
    required super.dateOfCalibration,
    required super.counterNO,
    required super.feedbackAmount,
  });

  factory CounterFeedbackAmountJSONModel.fromJson(Map<String, dynamic> json) {
    return CounterFeedbackAmountJSONModel(
        dateOfCalibration:
            DateFormat("yyyy-MM-dd").parse(json[DATE_OF_CALIBRATION]),
        counterNO: json[COUNTER_NO],
        feedbackAmount: json[FEEDBACK_AMOUNT]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE_OF_CALIBRATION: dateOfCalibration,
      COUNTER_NO: counterNO,
      FEEDBACK_AMOUNT: feedbackAmount,
    };
  }
}

class CounterDailyReadingJSONModel extends CounterDailyReadingEntity
    implements JSONModel {
  static const String TABLENAME = 'tblDigitalCountersReads';
  static const String DATE = "registeration_date";
  static const String COUNTER_NO = "counter_no";
  static const String COUNTER_READING = "counter_reading";

  const CounterDailyReadingJSONModel({
    required super.date,
    required super.counterNO,
    required super.counterReading,
  });

  factory CounterDailyReadingJSONModel.fromJson(Map<String, dynamic> json) {
    return CounterDailyReadingJSONModel(
        date: DateFormat("yyyy-MM-dd").parse(json[DATE]),
        counterNO: json[COUNTER_NO],
        counterReading: json[COUNTER_READING]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: date,
      COUNTER_NO: counterNO,
      COUNTER_READING: counterReading,
    };
  }
}

// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

import '../../../../../core/models/server_model.dart';
import '../../../domain/entities/tanks_pumps_counters_entity.dart';

class TankServerModel extends TankEntity implements ServerModel {
  static const String ENDPOINT = 'Tanks';
  static const String ID = "tank_No";
  static const String NAME = "tank_Name";
  static const String STATION_NAME = "station_Name";
  static const String CAPACITY = "max_Capacity";

  const TankServerModel({
    required super.id,
    required super.name,
    required super.stationName,
    required super.capacity,
  });

  factory TankServerModel.fromJson(Map<String, dynamic> json) {
    return TankServerModel(
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

class TankProductServerModel extends TankProductEntity implements ServerModel {
  static const String ENDPOINT = 'TanksContentType';
  static const String PRODUCT = "tanks_products";

  const TankProductServerModel({
    required super.product,
  });
  factory TankProductServerModel.fromJson(Map<String, dynamic> json) {
    return TankProductServerModel(product: json[PRODUCT]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      PRODUCT: product,
    };
  }
}

class TankContaintTypeServerModel extends TankContentTypeEntity
    implements ServerModel {
  static const String ENDPOINT = 'TanksContentType';
  static const String DATE = "date";
  static const String TANK_NO = "tank_No";
  static const String PRODUCT_NAME = "product";

  const TankContaintTypeServerModel({
    required super.date,
    required super.tankNo,
    required super.productName,
  });

  factory TankContaintTypeServerModel.fromJson(Map<String, dynamic> json) {
    return TankContaintTypeServerModel(
      date: DateFormat("yyyy-MM-dd").parse(json[DATE]),
      tankNo: json[TANK_NO],
      productName: json[PRODUCT_NAME],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      DATE: DateFormat("yyyy-MM-dd").format(date),
      TANK_NO: tankNo,
      PRODUCT_NAME: productName,
    };
  }
}

class TanksDailyMeasurementServerModel extends TanksDailyMeasurementEntity
    implements ServerModel {
  static const String ENDPOINT = 'TanksQuantity';
  static const String DATE = "registeration_date";
  static const String TANK_NO = "tank_no";
  static const String QUANTITY = "tank_stock_measurement";

  const TanksDailyMeasurementServerModel({
    required super.date,
    required super.tankNo,
    required super.quantity,
  });

  factory TanksDailyMeasurementServerModel.fromJson(Map<String, dynamic> json) {
    return TanksDailyMeasurementServerModel(
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

class TankEquilibriumServerModel extends TankEquilibriumEntity
    implements ServerModel {
  static const String ENDPOINT = 'Tbltanksequilibrium';
  static const String DATE = "date";
  static const String STATION_NAME = "stationName";
  static const String PRODUCT_NAME = "productName";
  static const String PRODUCT_NO = "productNo";
  static const String QUANTITY = "quantity";
  static const String NOTES = "Notes";

  const TankEquilibriumServerModel({
    required super.date,
    required super.stationName,
    required super.productName,
    required super.productNo,
    required super.quantity,
    super.notes,
  });

  factory TankEquilibriumServerModel.fromJson(Map<String, dynamic> json) {
    return TankEquilibriumServerModel(
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

class PumpServerModel extends PumpEntity implements ServerModel {
  static const String ENDPOINT = 'StationPumps';
  static const String PUMP_ID = "pump_no";
  static const String PUMP_NAME = "pump_name";

  const PumpServerModel({required super.pumpId, required super.pumpName});

  factory PumpServerModel.fromJson(Map<String, dynamic> json) {
    return PumpServerModel(pumpId: json[PUMP_ID], pumpName: json[PUMP_NAME]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {PUMP_ID: pumpId, PUMP_NAME: pumpName};
  }
}

class PumpOnTankServerModel extends PumpOnTankEntity implements ServerModel {
  static const String ENDPOINT = 'tblpumpstanksdetails';
  static const String WORK_ON_DATE = "date";
  static const String TANK_NO = "tank_no";
  static const String PUMP_ID = "pump_no";

  const PumpOnTankServerModel({
    required super.workOnDate,
    required super.tankNO,
    required super.pumpId,
  });

  factory PumpOnTankServerModel.fromJson(Map<String, dynamic> json) {
    return PumpOnTankServerModel(
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

class CounterServerModel extends CounterEntity implements ServerModel {
  static const String ENDPOINT = 'StationCounters';
  static const String COUNTER_ID = "counter_no";
  static const String COUNTER_NAME = "counter_name";

  const CounterServerModel(
      {required super.counterId, required super.counterName});

  factory CounterServerModel.fromJson(Map<String, dynamic> json) {
    return CounterServerModel(
        counterId: json[COUNTER_ID], counterName: json[COUNTER_NAME]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {COUNTER_ID: counterId, COUNTER_NAME: counterName};
  }
}

class CounterOnPumpServerModel extends CounterOnPumpEntity
    implements ServerModel {
  static const String ENDPOINT = 'tblcounterspumpsdetails';
  static const String WORK_ON_DATE = "date";
  static const String COUNTER_NO = "counter_no";
  static const String PUMP_ID = "pump_no";

  const CounterOnPumpServerModel({
    required super.workOnDate,
    required super.counterNO,
    required super.pumpId,
  });

  factory CounterOnPumpServerModel.fromJson(Map<String, dynamic> json) {
    return CounterOnPumpServerModel(
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

class CounterFeedbackAmountServerModel extends CounterFeedbackAmountEntity
    implements ServerModel {
  static const String ENDPOINT = 'tblcountersfeedback';
  static const String DATE_OF_CALIBRATION = "date";
  static const String COUNTER_NO = "counter_no";
  static const String FEEDBACK_AMOUNT = "feedback_amount_per_galon";

  const CounterFeedbackAmountServerModel({
    required super.dateOfCalibration,
    required super.counterNO,
    required super.feedbackAmount,
  });

  factory CounterFeedbackAmountServerModel.fromJson(Map<String, dynamic> json) {
    return CounterFeedbackAmountServerModel(
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

class CounterDailyReadingServerModel extends CounterDailyReadingEntity
    implements ServerModel {
  static const String ENDPOINT = 'tblDigitalCountersReads';
  static const String DATE = "registeration_date";
  static const String COUNTER_NO = "counter_no";
  static const String COUNTER_READING = "counter_reading";

  const CounterDailyReadingServerModel({
    required super.date,
    required super.counterNO,
    required super.counterReading,
  });

  factory CounterDailyReadingServerModel.fromJson(Map<String, dynamic> json) {
    return CounterDailyReadingServerModel(
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

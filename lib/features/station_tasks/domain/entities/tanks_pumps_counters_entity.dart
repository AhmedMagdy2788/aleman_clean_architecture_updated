import 'package:equatable/equatable.dart';

class TankEntity extends Equatable {
  final int id;
  final String name;
  final String stationName;
  final int capacity;

  const TankEntity(
      {required this.id,
      required this.name,
      required this.stationName,
      required this.capacity});

  @override
  List<Object?> get props => [id, name, stationName, capacity];
}

class TankProductEntity extends Equatable {
  final String product;

  const TankProductEntity({required this.product});

  @override
  List<Object?> get props => [product];
}

class TankContentTypeEntity extends Equatable {
  final DateTime date;
  final int tankNo;
  final String productName;

  const TankContentTypeEntity({
    required this.date,
    required this.tankNo,
    required this.productName,
  });

  @override
  List<Object?> get props => [date, tankNo, productName];
}

class TanksDailyMeasurementEntity extends Equatable {
  final DateTime date;
  final int tankNo;
  final double quantity;

  const TanksDailyMeasurementEntity({
    required this.date,
    required this.tankNo,
    required this.quantity,
  });

  @override
  List<Object?> get props => [date, tankNo, quantity];
}

class TankEquilibriumEntity extends Equatable {
  final DateTime date;
  final String stationName;
  final String productName;
  final int productNo;
  final double quantity;
  final String? notes;

  const TankEquilibriumEntity({
    required this.date,
    required this.stationName,
    required this.productName,
    required this.productNo,
    required this.quantity,
    this.notes,
  });

  @override
  List<Object?> get props =>
      [date, stationName, productName, productNo, quantity, notes];
}

class PumpEntity extends Equatable {
  final int pumpId;
  final String pumpName;

  const PumpEntity({
    required this.pumpId,
    required this.pumpName,
  });

  @override
  List<Object?> get props => [pumpId, pumpName];
}

class PumpOnTankEntity extends Equatable {
  final DateTime workOnDate;
  final int tankNO;
  final int pumpId;
  const PumpOnTankEntity(
      {required this.workOnDate, required this.tankNO, required this.pumpId});

  @override
  List<Object?> get props => [workOnDate, tankNO, pumpId];
}

class PumpTankDetailDtoEntity extends PumpTankDetailEntity {
  final String pumpName;
  final String tankName;
  final String tankContentType;

  const PumpTankDetailDtoEntity({
    required super.date,
    required super.pumpNo,
    required super.tankNo,
    required this.pumpName,
    required this.tankName,
    required this.tankContentType,
  });

  @override
  List<Object?> get props => [
        date,
        pumpNo,
        tankNo,
        pumpName,
        tankName,
        tankContentType,
      ];
}

class PumpTankDetailEntity extends Equatable {
  final DateTime date;
  final int pumpNo;
  final int tankNo;

  const PumpTankDetailEntity({
    required this.date,
    required this.pumpNo,
    required this.tankNo,
  });

  @override
  List<Object?> get props => [
        date,
        pumpNo,
        tankNo,
      ];
}

class CounterEntity extends Equatable {
  final int counterId;
  final String counterName;

  const CounterEntity({
    required this.counterId,
    required this.counterName,
  });

  @override
  List<Object?> get props => [counterId, counterName];
}

class CounterOnPumpEntity extends Equatable {
  final DateTime workOnDate;
  final int pumpId;
  final int counterNO;
  const CounterOnPumpEntity({
    required this.workOnDate,
    required this.pumpId,
    required this.counterNO,
  });

  @override
  List<Object?> get props => [
        workOnDate,
        pumpId,
        counterNO,
      ];
}

class CounterFeedbackAmountEntity extends Equatable {
  final DateTime dateOfCalibration;
  final int counterNO;
  final double feedbackAmount;
  const CounterFeedbackAmountEntity({
    required this.dateOfCalibration,
    required this.counterNO,
    required this.feedbackAmount,
  });

  @override
  List<Object?> get props => [
        dateOfCalibration,
        counterNO,
        feedbackAmount,
      ];
}

class CounterDailyReadingEntity extends Equatable {
  final DateTime date;
  final int counterNO;
  final double counterReading;

  const CounterDailyReadingEntity({
    required this.date,
    required this.counterNO,
    required this.counterReading,
  });

  @override
  List<Object?> get props => [date, counterNO, counterReading];
}

import 'package:aleman_clean_architecture_updated/core/error/failures.dart';
import 'package:aleman_clean_architecture_updated/core/network/network_info.dart';
import 'package:aleman_clean_architecture_updated/features/station_tasks/data/datasources/raw_table_db_data_source.dart';
import 'package:aleman_clean_architecture_updated/features/station_tasks/data/datasources/raw_table_json_data_source.dart';
import 'package:aleman_clean_architecture_updated/features/station_tasks/data/models/server_models/tank_server_model.dart';
import 'package:aleman_clean_architecture_updated/features/station_tasks/data/repositories/station_tasks_repository_imp.dart';
import 'package:aleman_clean_architecture_updated/features/station_tasks/domain/entities/station_entity.dart';
import 'package:aleman_clean_architecture_updated/features/station_tasks/domain/entities/tanks_pumps_counters_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() {
  late StationTasksRepositoryImpl repo;
  late StationEntity station;
  setUp(() {
    repo = StationTasksRepositoryImpl(
      networkInfo:
          NetworkInfoImpl(connectionChecker: InternetConnectionChecker()),
      jsonDataSource: RawTableJsonDataSourceImpl(directory: "assets/data"),
      dbDataSource:
          RawTableDBDataSourceImpl(uriLink: 'https://localhost:7072/api/'),
    );
    station = const StationEntity(
        id: 1,
        name: "محطة الودي",
        ownerCompany: "شركة الايمان",
        location: "الودي - الصف");
  });

  group("testing tank repository controller =>", () {
    test('test getStationTanksDetailsRows endpoint from db server', () async {
      //setup

      //do
      var result = await repo.getAllTanks();
      //test
      result.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<List<TankEntity>>());
        print("the list length = ${r.length}");
      });
    });
    test('test getStationTanksDetailsRows endpoint from db server', () async {
      //setup

      //do
      var result = await repo.getStationTanksDetailsRows(station);
      //test
      result.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<List<TankEntity>>());
        print("the list length = ${r.length}");
      });
    });
  });

  group("testing pumpTankDetails repository controller =>", () {
    test("test getPumpTankDetails endpoint from db server", () async {
      var either = await repo.getPumpTankDetails();
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<List<PumpTankDetailEntity>>());
        print("the list length = ${r.length}");
      });
    });

    test("test getAllPumpInstallations endpoint from db server", () async {
      //setup
      int pumpNo = 1;
      var either = await repo.getAllPumpInstallations(pumpNo);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<List<PumpTankDetailEntity>>());
        print("the list length = ${r.length}");
      });
    });

    test("test getPumpTankDetailByIds endpoint from db server", () async {
      //setup
      DateTime date = DateTime(2020, 10, 31);
      int pumpNo = 1;
      var either = await repo.getPumpTankDetailByIds(date, pumpNo);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<PumpTankDetailEntity>());
        print(r.toString());
      });
    });

    test("test getPumpTanksAtGeneralDate endpoint from db server", () async {
      //setup
      DateTime date = DateTime(2022, 04, 23);
      int pumpNo = 1;
      var either = await repo.getPumpTanksAtGeneralDate(date, pumpNo);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<PumpTankDetailEntity>());
        print(r.toString());
      });
    });

    test("test GetStationPumpTankDetailDtoAtGenralDate endpoint from db server",
        () async {
      //setup
      String stationName = "محطة الودي";
      DateTime date = DateTime(2022, 04, 23);
      var either =
          await repo.getStationPumpTankDetailDtoAtGenralDate(stationName, date);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<List<PumpTankDetailEntity>>());
        print("the list length = ${r.length}");
      });
    });

    test("test postPumpsTanksDetail endpoint from db server", () async {
      //setup
      PumpTankDetailEntity entity = PumpTankDetailServerModel(
        date: DateTime(2023, 6, 6, 10, 35, 15),
        pumpNo: 1,
        tankNo: 3,
      );
      var either = await repo.postPumpsTanksDetail(entity);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, equals(entity));
        print(r.toString());
      });
    });

    test("test putPumpsTanksDetail endpoint from db server", () async {
      //setup
      PumpTankDetailEntity entity = PumpTankDetailServerModel(
        date: DateTime(2023, 6, 6, 10, 35, 15),
        pumpNo: 1,
        tankNo: 2,
      );
      DateTime date = DateTime(2023, 6, 6, 10, 35, 15);
      int pumpNo = 1;
      var either = await repo.putPumpsTanksDetail(date, pumpNo, entity);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, equals(entity));
        print(r.toString());
      });
    });

    test("test deletePumpsTanksDetail endpoint from db server", () async {
      //setup
      DateTime date = DateTime(2023, 6, 6, 10, 35, 15);
      int pumpNo = 1;
      var either = await repo.deletePumpsTanksDetail(date, pumpNo);
      //test
      either.fold((l) {
        expect(l, isA<ServerFailure>());
        print(l.message);
      }, (r) {
        expect(r, isA<PumpTankDetailEntity>());
        expect(r.date, equals(date));
        expect(r.pumpNo, equals(pumpNo));
        print(r.toString());
      });
    });
  });
}

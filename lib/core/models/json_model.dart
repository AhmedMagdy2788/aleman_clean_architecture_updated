import 'package:equatable/equatable.dart';

import '../../features/station_tasks/data/models/json_files_models/customer_json_model.dart';
import '../../features/station_tasks/data/models/json_files_models/station_model.dart';
import '../../features/station_tasks/data/models/json_files_models/subcompany_json_model.dart';
import '../../features/station_tasks/data/models/json_files_models/user_model.dart';
import '../../features/station_tasks/domain/entities/customer_entity.dart';
import '../../features/station_tasks/domain/entities/station_entity.dart';
import '../../features/station_tasks/domain/entities/subcompany_entity.dart';
import '../entities/expanded_row_entity.dart';
import 'expanded_row_model.dart';

abstract class JSONModel extends Equatable {
  Map<String, dynamic> toJson();
  static Map<Type, JSONModel Function(Map<String, dynamic>)> mapEntitytoModel =
      {
    ExpandedRowEntity: ExpandedRowModel.fromJson,
    SubCompanyEntity: SubCompanyJSONModel.fromJson,
    StationEntity: StationJSONModel.fromJson,
    CustomerEntity: CustomerJSONModel.fromJson,
    UserJSONModel: UserJSONModel.fromJson,
  };
}

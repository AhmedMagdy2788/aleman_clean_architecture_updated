// ignore_for_file: constant_identifier_names
import 'package:equatable/equatable.dart';

abstract class ServerModel<Entity> extends Equatable {
  Map<String, dynamic> toJson();
}

class ServerAddRangeResponseModel extends Equatable {
  static const String SuccessAddedList = "";
  static const String DuplicatedList = "";
  static const String NotAcceptedList = "";

  final List<ServerModel> addedList;
  final List<ServerModel> duplicatedList;
  final List<ServerModel> notAcceptedList;

  const ServerAddRangeResponseModel(
      this.addedList, this.duplicatedList, this.notAcceptedList);

  @override
  List<Object?> get props => [addedList, duplicatedList, notAcceptedList];
}

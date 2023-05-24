import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/shared_preference_data_source.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  final SharedProferenceDataSource sharedProferenceDataSource;

  ThemeRepositoryImpl({required this.sharedProferenceDataSource});
  @override
  Future<Either<Failure, ThemeData>> getDarkTheme() {
    // TODO: implement getDarkTheme
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ThemeData>> getLightTheme() {
    // TODO: implement getLightTheme
    throw UnimplementedError();
  }
}

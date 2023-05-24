import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../repositories/theme_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_cases.dart';

class GetLightThemeUseCase extends UseCase<ThemeData, NoParams> {
  final ThemeRepository themeRepository;

  GetLightThemeUseCase(this.themeRepository);

  @override
  Future<Either<Failure, ThemeData>> call(NoParams params) async {
    return await themeRepository.getLightTheme();
  }
}

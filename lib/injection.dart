import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/app_themes/domain/repositories/theme_repository.dart';
import 'features/app_themes/domain/usecases/dark_theme_usecase.dart';
import 'features/app_themes/domain/usecases/light_theme_usecase.dart';
import 'features/app_themes/data/datasources/shared_preference_data_source.dart';
import 'features/app_themes/data/repositories/theme_repository_imp.dart';
import 'features/app_themes/presentation/bloc/app_themes_bloc.dart';
import 'features/station_tasks/data/repositories/station_tasks_repository_imp.dart';
import 'features/station_tasks/domain/repositories/station_tasks_repository.dart';
import 'features/station_tasks/domain/usecases/stations_usecases.dart';
import 'features/station_tasks/presentation/bloc/station_tasks_bloc.dart';
import 'features/station_tasks/presentation/bloc/stations_subcompanies_bloc/stations_of_companies_bloc.dart';
import 'features/station_tasks/data/datasources/raw_table_db_data_source.dart';
import 'features/station_tasks/data/datasources/raw_table_json_data_source.dart';
import 'features/station_tasks/data/repositories/stations_of_company_repository_impl.dart';
import 'features/station_tasks/domain/repositories/stations_of_company_repository.dart';
import 'features/station_tasks/domain/usecases/get_stations_of_company_usecase.dart';
import 'features/station_tasks/domain/usecases/get_subcompanies_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! featrues -app theme
  sl.registerFactory(() =>
      AppThemesBloc(getDarkThemeUseCase: sl(), getLightThemeUseCase: sl()));
  sl.registerLazySingleton(() => GetDarkThemeUseCase(sl()));
  sl.registerLazySingleton(() => GetLightThemeUseCase(sl()));

  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(sharedProferenceDataSource: sl()));

  sl.registerLazySingleton<SharedProferenceDataSource>(
      () => SharedProferenceDataSourceImp(sharedPreferences: sl()));

  //! featrues -stations of companies
  //Bloc
  sl.registerFactory(() => StationsOfCompaniesBloc(
        getStationOfCompanyUseCase: sl(),
        getSubCompaniesUseCase: sl(),
      ));
  sl.registerFactory(() => StationTasksBloc(
        getDailyReportUseCase: sl(),
        getMarketingCompaniesUseCase: sl(),
        getSubCompaniesUseCase: sl(),
        getStationCustomersUseCase: sl(),
        getCustomersTrucksUseCase: sl(),
        getStationsUseCase: sl(),
        getTanksDetailsUseCase: sl(),
        getTanksContentTypeUseCase: sl(),
        getTanksDailyMeasuermentsUseCase: sl(),
        getTanksEquilibriumUseCase: sl(),
        getDailyStationStockUseCase: sl(),
        getTanksProductsUseCase: sl(),
        addTankDetailseUseCase: sl(),
        addProductDetailsUseCase: sl(),
        getProductsUseCase: sl(),
        getProductsCategoriesUseCase: sl(),
        getProductsCommissionUseCase: sl(),
        getProductsPricesUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetDailyReportUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetStationOfCompanyUseCase(sl()));
  sl.registerLazySingleton(() => GetSubCompaniesUseCase(sl()));
  sl.registerLazySingleton(() => GetMarketingCompaniesUseCase(sl()));
  sl.registerLazySingleton(() => GetStationsUseCase(sl()));
  sl.registerLazySingleton(() => GetStationCustomersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCustomersTrucksUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTanksDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTanksContentTypeUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTanksProductsUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetTanksDailyMeasuermentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTanksEquilibriumUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetDailyStationStockUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTankDetailseUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddProductDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductsPricesUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetProductsCommissionUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetProductsCategoriesUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<StationOfCompanyRepository>(() =>
      StationOfCompanyRepositoryImpl(
          jsonDataSource: sl(), dbDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<StationTasksRepository>(() =>
      StationTasksRepositoryImpl(
          networkInfo: sl(), jsonDataSource: sl(), dbDataSource: sl()));

  //Data sources
  sl.registerLazySingleton<RawTableJsonDataSource>(
      () => RawTableJsonDataSourceImpl(directory: "assets/data"));
  sl.registerLazySingleton<RawTableDBDataSource>(
      () => RawTableDBDataSourceImpl(uriLink: 'https://localhost:7072/api/'));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shortway/core/error/failure_controller.dart';
import 'package:shortway/core/interceptors/connection_interceptor.dart';
import 'package:shortway/core/network/network_connection_stream.dart';
import 'package:shortway/data/datasources/api_remote_data_source.dart';
import 'package:shortway/data/repositories/field_brain_repository_impl.dart';
import 'package:shortway/data/repositories/path_finder_repository_impl.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';

/// Service Locator instance for dependency injection.
final sl = GetIt.instance;

/// Sets up and registers dependencies for the app.
class InjectionContainer {
  /// Initializes and registers dependencies asynchronously.
  Future<void> init() async {
    sl.registerLazySingleton<NetworkConnectionStream>(
      () => NetworkConnectionStream(),
      dispose: (instance) => instance.dispose(),
    );
    sl<NetworkConnectionStream>().init();

    sl.registerSingleton<FailureController>(FailureController());

    sl.registerLazySingleton<Dio>(
      () {
        final dio = Dio(BaseOptions(
          connectTimeout: const Duration(milliseconds: 10000),
          receiveTimeout: const Duration(milliseconds: 10000),
        ));
        dio.options.headers = {
          "content-type": "application/json",
          "Accept": "application/json",
        };
        dio.interceptors.add(ConnectionInterceptor(
          connectionStream: sl(),
        ));
        return dio;
      },
    );

    // DataSources
    sl.registerFactory<ApiRemoteDataSource>(
      () => ApiRemoteDataSourceImpl(httpDataSource: sl()),
    );

    // Repositories
    sl
      ..registerFactory<FieldBrainRepository>(
        () => FieldBrainRepositoryImpl(
          apiRemoteDataSource: sl(),
        ),
      )
      ..registerFactory<PathFinderRepository>(
        () => PathFinderRepositoryImpl(
          apiRemoteDataSource: sl(),
        ),
      );

    // ViewModels
  }
}

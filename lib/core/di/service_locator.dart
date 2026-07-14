import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/datasources/user_remote_datasource.dart';
import '../../features/home/data/repositories/user_repository_impl.dart';
import '../../features/home/domain/repositories/user_repository.dart';
import '../../features/home/domain/usecases/get_users_usecase.dart';
import '../../features/home/presentation/bloc/home_feed_bloc.dart';
import '../network/dio_client.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // ── Network ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // ── Data Sources ────────────────────────────────────────────────────────────
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl<Dio>()),
  );

  // ── Repositories ────────────────────────────────────────────────────────────
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl<UserRemoteDataSource>()),
  );

  // ── Use Cases ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(sl<UserRepository>()),
  );

  // ── Blocs (registered as factory so a new instance per page) ───────────────
  sl.registerFactory<HomeFeedBloc>(
    () => HomeFeedBloc(getUsersUseCase: sl<GetUsersUseCase>()),
  );
}

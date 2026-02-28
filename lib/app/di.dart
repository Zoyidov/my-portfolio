import 'package:get_it/get_it.dart';

import '../features/home/data/datasources/home_local_ds.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/get_home_overview.dart';
import '../features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSourceImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(local: sl()));
  sl.registerLazySingleton(() => GetHomeOverview(sl()));
  sl.registerFactory(() => HomeCubit(getHomeOverview: sl()));
}
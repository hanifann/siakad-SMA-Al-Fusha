import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/data/repositories/login_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/get_user_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/post_login_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/bloc/login_bloc.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/bloc/user_bloc.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/data/datasources/role_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/data/repositories/role_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/domain/repositories/role_repository.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/presentation/cubit/role_cubit.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/repositories/nilai_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/repositories/nilai_repository.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/usecases/get_nilai_usecase.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/presentation/bloc/nilai_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!features
  //auth
  //bloc
  sl.registerFactory(() => AuthCubit(sl()));

  //login
  //bloc
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => UserBloc(sl()));
  //usecases
  sl.registerLazySingleton(() => PostLoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl()));
  //repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), 
      networkInfo: sl()
    )
  );
  //datasources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl(), preferences: sl())
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(preferences: sl())
  );

  //role
  //cubit
  sl.registerFactory(() => RoleCubit(sl()));
  //usecase
  sl.registerLazySingleton(() => GetRoleUseCase(sl()));
  //repository
  sl.registerLazySingleton<RoleRepository>(
    () => RoleRepositoryImpl(sl())
  );
  //datasource
  sl.registerLazySingleton<RoleLocalDataSource>(
    () => RoleLocalDataSourceImpl(sl())
  );

  //nilai
  //bloc
  sl.registerFactory(() => NilaiBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => GetNilasiUseCase(repository: sl()));
  //repository
  sl.registerLazySingleton<NilaiRepository>(
    () => NilaiRepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), 
      networkInfo: sl(),
    )
  );
  //datasources
  sl.registerLazySingleton<NilaiRemoteDataSource>(
    () => NilaiRemoteDataSourceImpl(client: sl(), preferences: sl())
  );
  sl.registerLazySingleton<NilaiLocalDataSource>(
    () => NilaiLocalDataSourceImpl(preferences: sl())
  );
  

  //!external
  final prefs = await SharedPreferences.getInstance();
  final client = Client();
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
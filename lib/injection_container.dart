import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/repositories/announcement_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:siakad_sma_al_fusha/features/announcement/views/bloc/announcement_bloc.dart';
import 'package:siakad_sma_al_fusha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/repositories/evaluation_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_all_class_usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/bloc/class_bloc.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/data/repositories/login_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/get_user_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/post_login_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/bloc/login_bloc.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/bloc/user_bloc.dart';
import 'package:siakad_sma_al_fusha/features/home/data/datasources/role_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/home/data/repositories/role_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/repositories/role_repository.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/presentation/cubit/role_cubit.dart';
import 'package:siakad_sma_al_fusha/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:siakad_sma_al_fusha/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/datasources/nilai_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/datasources/nilai_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/repositories/nilai_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/repositories/nilai_repository.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/usecases/get_nilai_usecase.dart';
import 'package:siakad_sma_al_fusha/features/score_student/presentation/bloc/nilai_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!features
  //auth
  //bloc
  sl.registerFactory(() => AuthCubit(sl(), sl()));

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
  sl.registerFactory(() => NilaiBloc(sl(), sl()));
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

  //announcement
  //bloc
  sl.registerFactory(() => AnnouncementBloc(useCase: sl()));
  //useCases
  sl.registerLazySingleton(() => GetAnnouncementUseCase(repository: sl()));
  //repository
  sl.registerLazySingleton<AnnouncementRepository>(
    () => AnnouncementRepositoryImpl(
      networkInfo: sl(), 
      remoteDataSource: sl(), 
      localDataSource: sl()
    )
  );
  //datasources
  sl.registerLazySingleton<AnnouncementRemoteDataSource>(
    () => AnnouncementRemoteDataSourceImpl(client: sl(), preferences: sl())
  );
  sl.registerLazySingleton<AnnouncementLocalDataSource>(
    () => AnnouncementLocalDataSourceImpl(preferences: sl())
  );

  //schedule
  //bloc
  sl.registerFactory(() => ScheduleBloc(useCase: sl(), roleUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetScheduleUseCase(repository: sl()));
  //repository
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(
      networkInfo: sl(), 
      remoteDataSource: sl()
    )
  );
  //datasources
  sl.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(client: sl(), preferences: sl())
  );

  //evaluation
  //bloc
  sl.registerFactory(() => ClassBloc(classUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetAllClassUseCase(repository: sl()));
  //repositories
  sl.registerLazySingleton<EvaluationRepository>(
    () => EvaluationRepositoryImpl(
      networkInfo: sl(), 
      remoteDataSource: sl(), 
      localDataSource: sl()
    )
  );
  //datasources
  sl.registerLazySingleton<EvaluationRemoteDataSource>(
    () => EvaluationRemoteDataSourceImpl(client: sl(), preferences: sl())
  );
  sl.registerLazySingleton<EvaluationLocalDataSource>(
    () => EvaluationLocalDataSourceImpl(preferences: sl())
  );

  //profile
  //bloc
  sl.registerFactory(() => ProfileBloc(sl()));
  

  //!external
  final prefs = await SharedPreferences.getInstance();
  final client = Client();
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
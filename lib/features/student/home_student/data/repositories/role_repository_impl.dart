import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/data/datasources/role_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/domain/repositories/role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleLocalDataSource localDataSource;

  RoleRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, User>>? getRole() async {
    try {
      final jsonString = await localDataSource.getCachedRole();
      return Right(jsonString!);
    } on CacheException catch (_) {
      return const Left(CacheFailure());
    }
  }
}
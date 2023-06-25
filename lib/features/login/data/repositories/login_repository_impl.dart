import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/login.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource, 
    required this.localDataSource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, Login>>? postLogin(
    String username, 
    String password
  ) async {
    if(await networkInfo.isConnected){
      try {
        final result = await remoteDataSource.postLogin(
          username: username, 
          password: password
        );
        localDataSource.cachedLoginData(result);
        return Right(result);
      } on ServerException catch (e) {
        return Left(
          ServerFailure( 
            message: e.error.message
          )
        );
      }
    } else {
      return const Left(
        CacheFailure()
      );
    }
  }
  
}
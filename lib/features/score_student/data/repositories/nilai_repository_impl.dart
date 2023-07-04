import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/datasources/nilai_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/datasources/nilai_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/repositories/nilai_repository.dart';

class NilaiRepositoryImpl implements NilaiRepository {
  final NilaiRemoteDataSource remoteDataSource;
  final NilaiLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const NilaiRepositoryImpl({
    required this.remoteDataSource, 
    required this.localDataSource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, Nilai>>? getNilai(String id) async {
    if(await networkInfo.isConnected){
      try {
        final response  = await remoteDataSource.getNilai(id);
        localDataSource.cachedNilai(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedNilai();
        return Right(result!);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  } 
}
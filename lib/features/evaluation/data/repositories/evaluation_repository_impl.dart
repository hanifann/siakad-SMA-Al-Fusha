import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/score.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';

class EvaluationRepositoryImpl implements EvaluationRepository {
  final NetworkInfo networkInfo;
  final EvaluationRemoteDataSource remoteDataSource;
  final EvaluationLocalDataSource localDataSource;

  EvaluationRepositoryImpl({
    required this.networkInfo, 
    required this.remoteDataSource, 
    required this.localDataSource
  });

  @override
  Future<Either<Failure, Class>>? getAllClass() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getALlClass();
        localDataSource.cachedKelas(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try{
        final result = await localDataSource.getCahchedKelas();
        return Right(result!);
      } on CacheException catch(e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Student>>? getStudentByClass(String classId) async {
   if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getStudentByClass(classId);
        localDataSource.chachedStudent(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try{
        final result = await localDataSource.getChachedStudent();
        return Right(result!);
      } on CacheException catch(e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, LessonCode>>? getLessonCode() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getLessonCode();
        localDataSource.cachedLessonCode(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try{
        final result = await localDataSource.getCachedLessonCode();
        return Right(result!);
      } on CacheException catch(e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Score>>? postScore({
    required String lessonCode, 
    required String rph, 
    required String pts, 
    required String pat
  }) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.postScoreModel(
          lessonCode: lessonCode,
          rph: rph,
          pts: pts,
          pat: pat
        );
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(ServerFailure());
    }
  }
  
}
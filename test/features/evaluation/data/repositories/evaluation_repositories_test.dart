import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/student_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/repositories/evaluation_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/repositories/login_repository_impl_test.mocks.dart';
import 'evaluation_repositories_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<EvaluationRemoteDataSource>(),
  MockSpec<EvaluationLocalDataSource>()
])
void main() {
  late MockEvaluationRemoteDataSource remoteDataSource;
  late MockEvaluationLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;
  late EvaluationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockEvaluationRemoteDataSource();
    localDataSource = MockEvaluationLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = EvaluationRepositoryImpl(
      networkInfo: networkInfo, 
      remoteDataSource: remoteDataSource, 
      localDataSource: localDataSource
    );
  });
  
  group('class', () {
    final tClassModel = ClassModel.fromJson(jsonDecode(fixture('class.json')));

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      });

      test('should return class data when call to remote datasource success',
      () async {
        //arrange
        when(remoteDataSource.getALlClass())
          .thenAnswer((_) async => tClassModel);

        //act
        final response = await repositoryImpl.getAllClass();

        //assert
        verify(remoteDataSource.getALlClass());
        expect(response, equals(Right(tClassModel)));
      });

      test('should cached data when call to remote datasource success', 
        () async{
        //arrange
        when(remoteDataSource.getALlClass())
          .thenAnswer((_) async => tClassModel);
        //act
        await repositoryImpl.getAllClass();
        //assert
        verify(remoteDataSource.getALlClass());
        verify(localDataSource.cachedKelas(tClassModel));
      });

      test('should return ServerFailure when call to remote datasource failed',
       () async {
        //arrange
        when(remoteDataSource.getALlClass())
          .thenThrow(ServerException(
            error: const ErrorModel(message: 'error'))
          );
        //act
        final response = await repositoryImpl.getAllClass();
        //assert
        verify(remoteDataSource.getALlClass());
        expect(response, equals(const Left(ServerFailure(message: 'error'))));
        verifyZeroInteractions(localDataSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected)
          .thenAnswer((_) async => false);
      });

      test('should return last locally cached data', () async {
        //arrange
        when(localDataSource.getCahchedKelas())
          .thenAnswer((_) async => tClassModel);
        //act
        final result = await repositoryImpl.getAllClass();
        //assert
        verify(localDataSource.getCahchedKelas());
        verifyZeroInteractions(remoteDataSource);
        expect(result, equals(Right(tClassModel)));
      });

      test('should return CacheFailure when there is no chached data',()async{
        //arrange
        when(localDataSource.getCahchedKelas())
        .thenThrow(CacheException(message: 'error'));
        //act
        final result = await repositoryImpl.getAllClass();
        //assert
        verify(localDataSource.getCahchedKelas());
        verifyZeroInteractions(remoteDataSource);
        expect(result, equals(const Left(CacheFailure(message: 'error'))));
      });
    });
  });

    group('student by class', () {
    final tStudentModel = StudentModel.fromJson(jsonDecode(fixture('student.json')));
    const tClassId = '1';

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected)
          .thenAnswer((_) async => true);
      });

      test('should return student data when call to remote datasource success',
      () async {
        //arrange
        when(remoteDataSource.getStudentByClass(tClassId))
          .thenAnswer((_) async => tStudentModel);

        //act
        final response = await repositoryImpl.getStudentByClass(tClassId);

        //assert
        verify(remoteDataSource.getStudentByClass(tClassId));
        expect(response, equals(Right(tStudentModel)));
      });

      test('should cached data when call to remote datasource success', 
        () async{
        //arrange
        when(remoteDataSource.getStudentByClass(tClassId))
          .thenAnswer((_) async => tStudentModel);
        //act
        await repositoryImpl.getStudentByClass(tClassId);
        //assert
        verify(remoteDataSource.getStudentByClass(tClassId));
        verify(localDataSource.chachedStudent(tStudentModel));
      });

      test('should return ServerFailure when call to remote datasource failed',
       () async {
        //arrange
        when(remoteDataSource.getStudentByClass(tClassId))
          .thenThrow(ServerException(
            error: const ErrorModel(message: 'error'))
          );
        //act
        final response = await repositoryImpl.getStudentByClass(tClassId);
        //assert
        verify(remoteDataSource.getStudentByClass(tClassId));
        expect(response, equals(const Left(ServerFailure(message: 'error'))));
        verifyZeroInteractions(localDataSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected)
          .thenAnswer((_) async => false);
      });

      test('should return last locally cached data', () async {
        //arrange
        when(localDataSource.getChachedStudent())
          .thenAnswer((_) async => tStudentModel);
        //act
        final result = await repositoryImpl.getStudentByClass(tClassId);
        //assert
        verify(localDataSource.getChachedStudent());
        verifyZeroInteractions(remoteDataSource);
        expect(result, equals(Right(tStudentModel)));
      });

      test('should return CacheFailure when there is no chached data',()async{
        //arrange
        when(localDataSource.getChachedStudent())
        .thenThrow(CacheException(message: 'error'));
        //act
        final result = await repositoryImpl.getStudentByClass(tClassId);
        //assert
        verify(localDataSource.getChachedStudent());
        verifyZeroInteractions(remoteDataSource);
        expect(result, equals(const Left(CacheFailure(message: 'error'))));
      });
    });
  });
}
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/models/nilai_model.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/repositories/nilai_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/repositories/login_repository_impl_test.mocks.dart';
import 'nilai_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NilaiRemoteDataSource>(),
  MockSpec<NilaiLocalDataSource>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockNilaiRemoteDataSource mockRemoteDataSource;
  late MockNilaiLocalDataSource mockLocalDataSource;
  late NilaiRepositoryImpl repositoryImpl;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockNilaiRemoteDataSource();
    mockLocalDataSource = MockNilaiLocalDataSource();
    repositoryImpl = NilaiRepositoryImpl(
      remoteDataSource: mockRemoteDataSource, 
      localDataSource: mockLocalDataSource, 
      networkInfo: mockNetworkInfo
    );
  });

  final tNilai = NilaiModel.fromJson(jsonDecode(fixture('nilai.json')));
  const tId = '1';

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);
    });

    test('should return nilai when call to remote datasource is success',
    () async {
      //arrange
      when(mockRemoteDataSource.getNilai(tId))
        .thenAnswer((_) async => tNilai);
      
      //act
      final response = await repositoryImpl.getNilai(tId);

      //assert
      verify(mockRemoteDataSource.getNilai(tId));
      expect(response, equals(Right(tNilai)));
    });

    test('should cached nilai when call to remote datasource is success', 
    () async {
      //arrange
      when(mockRemoteDataSource.getNilai(tId))
        .thenAnswer((_) async => tNilai);

      //act
      await repositoryImpl.getNilai(tId);

      //assert
      verify(mockRemoteDataSource.getNilai(tId));
      verify(mockLocalDataSource.cachedNilai(tNilai));
    });

    test('should return ServerFailure() when call to remote datasource'
     'is failed', () async {
      //arrange
      when(mockRemoteDataSource.getNilai(tId))
        .thenThrow(ServerException(error: const ErrorModel(message: 'error')));
      
      //act
      final response = await repositoryImpl.getNilai(tId);

      //assert
      verify(mockRemoteDataSource.getNilai(tId));
      verifyZeroInteractions(mockLocalDataSource);
      expect(response, equals(const Left(ServerFailure(message: 'error'))));
    });
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => false);
    });

    test('should return last locally cached nilai data', () async {
      //arrange
      when(mockLocalDataSource.getCachedNilai())
        .thenAnswer((_) async => tNilai);
      
      //act
      final response = await repositoryImpl.getNilai(tId);

      //assert
      verify(mockLocalDataSource.getCachedNilai());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(response, equals(Right(tNilai)));
    });

    test('should return CacheFailure when there is no cached data', () async {
      //arrange
      when(mockLocalDataSource.getCachedNilai())
        .thenThrow(CacheException(
          message: 'test'
        ));
      
      //act
      final response = await repositoryImpl.getNilai(tId);

      //assert
      verify(mockLocalDataSource.getCachedNilai());
      verifyZeroInteractions(mockRemoteDataSource);
      expect(
        response, equals(const Left(CacheFailure(message: 'test'))));
    });
  });
  
}
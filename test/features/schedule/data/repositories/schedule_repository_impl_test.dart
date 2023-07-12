import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/models/schedule_model.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/repositories/schedule_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/repositories/login_repository_impl_test.mocks.dart';
import 'schedule_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ScheduleRemoteDataSource>()])
void main() {
  late MockScheduleRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ScheduleRepositoryImpl repositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockScheduleRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ScheduleRepositoryImpl(
      networkInfo: mockNetworkInfo, 
      remoteDataSource: mockRemoteDataSource
    );
  });

  final tScheduleModel = ScheduleModel.fromJson(jsonDecode(fixture('schedule.json')));
  const tId = '1';
  const tDay = 'sunday';

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);
    });

    test('should return schedule when call to remote datasource success', 
    () async {
      //arrange
      when(mockRemoteDataSource.getSchedule(tId, tDay))
        .thenAnswer((_) async => tScheduleModel);
      
      //act
      final response = await repositoryImpl.getSchedule(tId, tDay);

      //assert
      verify(mockRemoteDataSource.getSchedule(tId, tDay));
      expect(response, equals(Right(tScheduleModel)));
    });

    test('should return ServerFailure when call to remote data source'
    ' is failed', () async {
      //arrange
      when(mockRemoteDataSource.getSchedule(tId, tDay))
        .thenThrow(ServerException(error: const ErrorModel(message: 'error')));
      
      //act
      final response = await repositoryImpl.getSchedule(tId, tDay);

      //assert
      verify(mockRemoteDataSource.getSchedule(tId, tDay));
      expect(response, equals(const Left(ServerFailure(message: 'error'))));
    });
  });
  
  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => false);
    });

    test('should return ServerFailure when device is offline', () async {
      //arrange
      when(mockRemoteDataSource.getSchedule(tId, tDay))
        .thenAnswer((_) async => tScheduleModel);
      
      //act
      final response = await repositoryImpl.getSchedule(tId, tDay);

      //assert
      expect(response, equals(const Left(ServerFailure())));
    });
  });
}
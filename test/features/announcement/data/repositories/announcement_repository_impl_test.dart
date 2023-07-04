import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/models/announcement_model.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/repositories/announcement_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/repositories/login_repository_impl_test.mocks.dart';
import 'announcement_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AnnouncementRemoteDataSource>(),
  MockSpec<AnnouncementLocalDataSource>()
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockAnnouncementRemoteDataSource remoteDataSource;
  late MockAnnouncementLocalDataSource localDataSource;
  late AnnouncementRepositoryImpl repositoryImpl;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    remoteDataSource = MockAnnouncementRemoteDataSource();
    localDataSource = MockAnnouncementLocalDataSource();
    repositoryImpl = AnnouncementRepositoryImpl(
      networkInfo: mockNetworkInfo, 
      remoteDataSource: remoteDataSource, 
      localDataSource: localDataSource
    );
  });

  final tAnnouncementModel = AnnouncementModel.fromJson(
    jsonDecode(fixture('announcement.json'))
  );

  final tAnnouncement = tAnnouncementModel;

group('device is online', () {
  setUp(() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  });

  test('should return announcement data when call to remote data souce is' 
  'success', () async {
    //arrange
    when(remoteDataSource.getAnnouncement())
      .thenAnswer((_) async => tAnnouncementModel);

    //act
    final response = await repositoryImpl.getAnnouncement();

    //assert
    verify(remoteDataSource.getAnnouncement());
    expect(response, equals(Right(tAnnouncement)));
  });

  test('should cached announcement data when call to remote data souce is' 
  'success', () async {
    //arrange
    when(remoteDataSource.getAnnouncement())
      .thenAnswer((_) async => tAnnouncementModel);
    //act
    await repositoryImpl.getAnnouncement();

    //assert
    verify(remoteDataSource.getAnnouncement());
    verify(localDataSource.cachedAnnouncement(tAnnouncementModel));
  });

  test('should return ServerFailure when call to remote data source is' 
  'failed', () async {
    //arrange
    when(remoteDataSource.getAnnouncement())
      .thenThrow(ServerException(error: const ErrorModel(message: "error")));

    //act
    final response = await repositoryImpl.getAnnouncement();

    //assert
    verify(remoteDataSource.getAnnouncement());
    expect(response, equals(const Left(ServerFailure(message: 'error'))));
    verifyZeroInteractions(localDataSource);
  });
});

group('device is offline', () { 
  setUp(() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  });

  test('should return last locally cached announcement data', () async {
    //arrange
    when(localDataSource.getCachedAnnouncement())
    .thenAnswer((_) async => tAnnouncementModel);

    //act
    final result = await repositoryImpl.getAnnouncement();
    
    //assert
    verify(localDataSource.getCachedAnnouncement());
    expect(result, equals(Right(tAnnouncement)));
    verifyZeroInteractions(remoteDataSource);
  });

  test('should return CacheFailure when there is no cached data', () async {
    //arrange
    when(localDataSource.getCachedAnnouncement())
      .thenThrow(CacheException(message: 'error'));

    //act
    final result = await repositoryImpl.getAnnouncement();

    //assert
    verify(localDataSource.getCachedAnnouncement());
    expect(result, equals(const Left(CacheFailure(message: 'error'))));
    verifyZeroInteractions(remoteDataSource);
  });
});
}
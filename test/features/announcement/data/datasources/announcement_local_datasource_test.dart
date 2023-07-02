import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/data/datasources/announcement_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/data/models/announcement_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AnnouncementLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = AnnouncementLocalDataSourceImpl(
      preferences: mockSharedPreferences
    );
  });

  final tAnnouncementModel = AnnouncementModel.fromJson(
    jsonDecode(fixture('announcement.json'))
  );

  test('should call shared preference to cached announcement data', () {
    //act
    dataSourceImpl.cachedAnnouncement(tAnnouncementModel);

    //assert
    verify(mockSharedPreferences.setString(
      Env.announcement, jsonEncode(tAnnouncementModel.toJson()))
    );
  });

  test('should return announcement data when available', () async {
    //arrange
    when(mockSharedPreferences.getString(Env.announcement))
      .thenAnswer((_) => fixture('announcement.json'));

    //act
    final result = await dataSourceImpl.getCachedAnnouncement();

    //assert
    verify(mockSharedPreferences.getString(Env.announcement));
    expect(result, equals(tAnnouncementModel));
  });

  test('should throw CacheException when there is no data available', () async{
    //arrange
    when(mockSharedPreferences.getString(Env.announcement))
      .thenThrow(CacheException());

    //act
    final call = dataSourceImpl.getCachedAnnouncement;

    //assert
    expect(()=> call(), throwsA(const TypeMatcher<CacheException>()));
  });
}
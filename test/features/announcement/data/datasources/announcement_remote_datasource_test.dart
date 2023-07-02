import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/data/datasources/announcement_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/data/models/announcement_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';
import '../../../login/data/datasources/login_remote_data_source_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MockClient mockClient;
  late AnnouncementRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockClient = MockClient();
    dataSourceImpl = AnnouncementRemoteDataSourceImpl(
      client: mockClient, 
      preferences: mockSharedPreferences
    );
  });

  final tAnnouncementModel = AnnouncementModel.fromJson(
    jsonDecode(fixture('announcement.json'))
  );

  void setupMockHttpClientSuccess200() {
      when(mockClient.get(
        Uri.https(Env.url, '/api/pengumuman'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )).thenAnswer((_) async => Response(fixture('announcement.json'), 200));
   }

  test('should perform get request to remote data source ', () {
    //arrange
    setupMockHttpClientSuccess200();

    //act
    dataSourceImpl.getAnnouncement();

    //assert
    verify(
      mockClient.get(
        Uri.https(Env.url, '/api/pengumuman'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
    );
  });

  test('should return announcement model when response code is 200', () async {
    //arrange
    setupMockHttpClientSuccess200();

    //act
    final response = await dataSourceImpl.getAnnouncement();

    //assert
    expect(response, equals(tAnnouncementModel));
  });

  test('should throw serverException when response code is not 200', () async {
    //arrange
    when(
      mockClient.get(
        Uri.https(Env.url, '/api/pengumuman'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
    ).thenThrow(ServerException(error: const ErrorModel()));

    //act
    final call = dataSourceImpl.getAnnouncement;

    //assert
    expect(()=> call(), throwsA(const TypeMatcher<ServerException>()));
  });
}
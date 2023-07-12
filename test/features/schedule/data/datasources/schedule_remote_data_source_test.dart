import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/models/schedule_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';
import '../../../login/data/datasources/login_remote_data_source_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late MockSharedPreferences mockSharedPreferences;
  late ScheduleRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    remoteDataSourceImpl = ScheduleRemoteDataSourceImpl(
      client: mockClient, 
      preferences: mockSharedPreferences
    );
  });

  final tSchedule = ScheduleModel.fromJson(jsonDecode(fixture('schedule.json')));
  const tId = '1';
  const tDay = 'sunday';

  void setupMockHttpClientSuccess200() {
    when(mockClient.get(
      Uri.https(Env.url, '/api/jadwal_pelajaran/$tId/$tDay'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer null'
      },
    )).thenAnswer((_) async => Response(fixture('schedule.json'), 200));
  }
  
  test('should perform get request to remote data source', () async {
    //arrange
    setupMockHttpClientSuccess200();

    //act
    remoteDataSourceImpl.getSchedule(tId, tDay);

    //assert
    verify(
      mockClient.get(
      Uri.https(Env.url, '/api/jadwal_pelajaran/$tId/$tDay'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
    );
  });

  test('should return schedule when response code is 200',()async{
    //arrange
    setupMockHttpClientSuccess200();

    //act
    final response = await remoteDataSourceImpl.getSchedule(tId, tDay);

    //assert
    expect(response, equals(tSchedule));
  });

  test('should throw serverException when response code is not 200',()async{
    //arrange
    when(mockClient.get(
      Uri.https(Env.url, '/api/jadwal_pelajaran/$tId/$tDay'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer null'
      },
    )).thenThrow(ServerException(error: const ErrorModel()));

    //act
    final call = remoteDataSourceImpl.getSchedule;

    //assert
    expect(()=> call(tId, tDay), throwsA(const TypeMatcher<ServerException>()));
  });
}
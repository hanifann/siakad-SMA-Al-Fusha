import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/datasources/nilai_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/models/nilai_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';
import '../../../login/data/datasources/login_remote_data_source_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late MockSharedPreferences mockSharedPreferences;
  late NilaiRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    remoteDataSourceImpl = NilaiRemoteDataSourceImpl(
      client: mockClient, 
      preferences: mockSharedPreferences
    );
  });

  final tNilai = NilaiModel.fromJson(jsonDecode(fixture('nilai.json')));
  const tId = '1';
  
  void setupMockHttpClientSuccess200() {
      when(mockClient.get(
        Uri.https(Env.url, '/api/nilai/$tId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )).thenAnswer((_) async => Response(fixture('nilai.json'), 200));
   }

  test('should perform get request to remote datasource', () async {
    //arrange
    setupMockHttpClientSuccess200();

    remoteDataSourceImpl.getNilai(tId);

    verify(
      mockClient.get(
        Uri.https(Env.url, '/api/nilai/$tId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
    );
  });

  test('should return nilai when response code is 200', () async {
    //arrange
    setupMockHttpClientSuccess200();

    //act
    final response = await remoteDataSourceImpl.getNilai(tId);

    //assert
    expect(response, equals(tNilai));
  });

  test('should trhow serverException when response code is not 200', () async {
    //arrange
    when(
      mockClient.get(
        Uri.https(Env.url, '/api/nilai/$tId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
    ).thenThrow(ServerException(error: const ErrorModel(message: 'test')));

    //act
    final call = remoteDataSourceImpl.getNilai;

    //assert
    expect(()=> call(tId), throwsA(const TypeMatcher<ServerException>()));
  });
}
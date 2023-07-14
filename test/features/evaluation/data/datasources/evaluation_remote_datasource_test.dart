import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';
import '../../../login/data/datasources/login_remote_data_source_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late MockSharedPreferences mockSharedPreferences;
  late EvaluationRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    remoteDataSourceImpl = EvaluationRemoteDataSourceImpl(
      client: mockClient, 
      preferences: mockSharedPreferences
    );
  });
  
  group('class', () {
    final tClass = ClassModel.fromJson(jsonDecode(fixture('class.json')));

    void setupMockHttpClientSuccess200() {
      when(mockClient.get(
        Uri.https(Env.url, '/api/kelas'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )).thenAnswer((_) async => Response(fixture('class.json'), 200));
   }

    test('should perform get request to remote datasource',()async{
      //arrange
      setupMockHttpClientSuccess200();
      //act
      remoteDataSourceImpl.getALlClass();
      //assert
      verify(
        mockClient.get(
        Uri.https(Env.url, '/api/kelas'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
      );
    });

    test('should return class data when response code is 200', () async{
      //arrange
      setupMockHttpClientSuccess200();
      //act
      final response = await remoteDataSourceImpl.getALlClass();
      //assert
      expect(response, equals(tClass));
    });

    test('shuld throw ServerException when status code is not 200',()async{
      //arrange
      when(
        mockClient.get(
        Uri.https(Env.url, '/api/kelas'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )
      ).thenThrow(ServerException(error: const ErrorModel(message: 'error')));

      //act
      final call = remoteDataSourceImpl.getALlClass;

      //assert
      expect(()=> call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
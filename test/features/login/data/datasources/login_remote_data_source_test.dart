import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'login_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  late MockClient mockHttpClient;
  late LoginRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tUsername = '54321';
  const tPassword = '54321';
  final tLoginModel = LoginModel.fromJson(jsonDecode(fixture('login.json')));

  void setupMockHttpClientSuccess200() {
    when(mockHttpClient.post(
      Uri.https(Env.url, '/api/login'),
      headers: {
        'Accept': 'application/json'
      },
      body: {
        'username': tUsername,
        'password': tPassword
      }
    )).thenAnswer((_) async => Response(fixture('login.json'), 200));
  }

  test('should perform post request on url with username and password as body', 
    () async {
    //arrange
    setupMockHttpClientSuccess200();

    //act
    remoteDataSource.postLogin(
      username: tUsername, 
      password: tPassword
    );

    //assert
      verify(mockHttpClient.post(
        Uri.https(Env.url, '/api/login'),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'username': tUsername,
          'password': tPassword
        }
      ));
  });

  test('should return Login object when response code is 200', () async {
    //arrange
    setupMockHttpClientSuccess200();

    //act
    final response = await remoteDataSource.postLogin(
      username: tUsername, password: tPassword
    );

    //assert
    expect(response, equals(tLoginModel));
  });
  
}
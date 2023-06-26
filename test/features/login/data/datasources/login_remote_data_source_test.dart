import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'login_local_datasource_test.mocks.dart';
import 'login_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  late MockClient mockHttpClient;
  late LoginRemoteDataSourceImpl remoteDataSource;
  late MockSharedPreferences preferences;

  setUp(() {
    mockHttpClient = MockClient();
    preferences = MockSharedPreferences();
    remoteDataSource = LoginRemoteDataSourceImpl(
      client: mockHttpClient, 
      preferences: preferences
    );
  });

  group('login', () {
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

    test('should return error object when response code is not 200', () async {
      //arrange
      when(mockHttpClient.post(
        Uri.https(Env.url, '/api/login'),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'username': tUsername,
          'password': tPassword
        }
      )).thenAnswer((_) async => Response(fixture('login_error.json'), 400));

      //act
      final call = remoteDataSource.postLogin;

      //assert
      expect(
        ()=> call(username: tUsername, password: tPassword), 
        throwsA(const TypeMatcher<ServerException>())
      );
    });
  });

  group('get user', () {
    final tUserDatumModel = UserDatumModel(
      id: '1', 
      nama: 'nama', 
      username: 'username', 
      role: '2', 
      idUsers: '13', 
      tempat: 'tempat', 
      tglLahir: DateTime(2023), 
      pendidikan: null, 
      tmk: DateTime(2023), 
      jabatan: 'jabatan', 
      alamat: 'alamat', 
      tgsTam: 'tgsTam'
    );

    final tUserModel = UserModel(data: [tUserDatumModel]);

    void setupMockHttpClientSuccess200() {
      when(mockHttpClient.get(
        Uri.https(Env.url, '/api/me'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )).thenAnswer((_) async => Response(fixture('user.json'), 200));
    }

    test('should perform get request to remote datasource', () async {
      //arrange
      setupMockHttpClientSuccess200();

      //act
      remoteDataSource.getUser();

      //assert
      verify(
        mockHttpClient.get(
          Uri.https(Env.url, '/api/me'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer null'
          },
        )
      );
    });

    test('should return user data when response code is 200', () async {
      //arrange
      setupMockHttpClientSuccess200();

      //act
      final response = await remoteDataSource.getUser();

      //assert
      expect(response, equals(tUserModel));
    });

    test('should throw server exception when response code is not 200',()async{
      //arrange
      when(mockHttpClient.get(
        Uri.https(Env.url, '/api/me'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer null'
        },
      )).thenThrow(ServerException(error: const ErrorModel()));

      //act
      final call = remoteDataSource.getUser;
      
      //assert
      expect(call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
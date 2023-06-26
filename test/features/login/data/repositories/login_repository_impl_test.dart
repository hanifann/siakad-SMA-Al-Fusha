import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';
import 'package:siakad_sma_al_fusha/features/login/data/repositories/login_repository_impl.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginRemoteDataSource>(),
  MockSpec<LoginLocalDataSource>(),
  MockSpec<NetworkInfo>()
])
void main() {
  late MockLoginRemoteDataSource mockLoginRemoteDataSource;
  late MockLoginLocalDataSource mockLoginLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late LoginRepositoryImpl repositoryImpl;

  setUp(() {
    mockLoginRemoteDataSource = MockLoginRemoteDataSource();
    mockLoginLocalDataSource = MockLoginLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = LoginRepositoryImpl(
      remoteDataSource: mockLoginRemoteDataSource, 
      localDataSource: mockLoginLocalDataSource, 
      networkInfo: mockNetworkInfo
    );
  });

  const tUsername = '54321';
  const tPassword = '54321';
  const tLoginModel = LoginModel(data: 'token');

  const tUserDatum = UserDatumModel(
    id: '1', 
    nama: 'nama', 
    username: 'username', 
    role: '2', 
    idUsers: '13', 
    tempat: 'tempat', 
    tglLahir: null, 
    pendidikan: null, 
    tmk: null, 
    jabatan: 'jabatan', 
    alamat: 'alamat', 
    tgsTam: 'tgsTam'
  );
  const tUser = UserModel(data: [tUserDatum]);

  group('device is online', () {
    setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repositoryImpl.postLogin(tUsername, tPassword);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return remote data when call to remote data source success', 
    () async {
      //arrange
      when(
        mockLoginRemoteDataSource.postLogin(
          username: tUsername, password: tPassword
        )
      ).thenAnswer((_) async => tLoginModel);

      //act
      final response = await repositoryImpl.postLogin(tUsername, tPassword);

      //assert
      verify(repositoryImpl.postLogin(tUsername, tPassword));
      expect(response, equals(const Right(tLoginModel)));
    });

    test('should cache data locally when call to remote datasource success', 
    () async {
      //arrange
      when(
        mockLoginRemoteDataSource.postLogin(
          username: tUsername, password: tPassword
        )
      ).thenAnswer((_) async => tLoginModel);

      //act
      await repositoryImpl.postLogin(tUsername, tPassword);

      //assert
      verify(
        mockLoginRemoteDataSource.postLogin(username: tUsername, password: tPassword)
      );
      verify(mockLoginLocalDataSource.cachedLoginData(tLoginModel));
    });

    test('should return user data when call to remote data source success', 
      () async {
      //arrange
      when(mockLoginRemoteDataSource.getUser())
        .thenAnswer((_) async => tUser);

      //act
      final response = await repositoryImpl.getUser();

      //assert
      verify(mockLoginRemoteDataSource.getUser());
      expect(response, equals(const Right(tUser)));
    });

    test('should cached user data when call to remote data source success', 
    () async {
      //arrange
      when(mockLoginRemoteDataSource.getUser())
        .thenAnswer((_) async => tUser);

      //act
      await repositoryImpl.getUser();

      //assert
      verify(mockLoginRemoteDataSource.getUser());
      verify(mockLoginLocalDataSource.cachedUserData(tUser));
    });
  });
}
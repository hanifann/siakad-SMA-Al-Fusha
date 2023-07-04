import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';
import 'package:siakad_sma_al_fusha/features/home/data/datasources/role_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/home/data/repositories/role_repository_impl.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'role_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RoleLocalDataSource>()])
void main() {
  late MockRoleLocalDataSource mockRoleLocalDataSource;
  late RoleRepositoryImpl repositoryImpl;

  setUp(() {
    mockRoleLocalDataSource = MockRoleLocalDataSource();
    repositoryImpl = RoleRepositoryImpl(mockRoleLocalDataSource);
  });

  final tUser = UserModel.fromJson(jsonDecode(fixture('user.json')));

  test('should return locally cached user data when available', () async {
    //arrange
    when(mockRoleLocalDataSource.getCachedRole())
      .thenAnswer((_) async => tUser);

    //arrange
    final response = await repositoryImpl.getRole();

    //assert
    verify(mockRoleLocalDataSource.getCachedRole());
    expect(response, equals(Right(tUser)));
  });

  test('should return cacheFailure when there is no data available', () async {
    //arrange
    when(mockRoleLocalDataSource.getCachedRole())
      .thenThrow(CacheException());
    
    //act
    final result = await repositoryImpl.getRole();

    //assert
    verify(mockRoleLocalDataSource.getCachedRole());
    expect(result, equals(const Left(CacheFailure())));
  });
}
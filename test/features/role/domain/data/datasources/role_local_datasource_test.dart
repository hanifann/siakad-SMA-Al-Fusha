
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/home/data/datasources/role_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../login/data/datasources/login_local_datasource_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late RoleLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = RoleLocalDataSourceImpl(mockSharedPreferences);
  });

  final tUser = jsonDecode(fixture('user.json'));

  test('should return role from shared preference', () async {
    //arrange
    when(mockSharedPreferences.getString(Env.user))
      .thenAnswer((_) => fixture('user.json'));
    
    //act
    final result = await dataSourceImpl.getCachedRole();

    //assert
    expect(result, equals(UserModel.fromJson(tUser)));
  });
}
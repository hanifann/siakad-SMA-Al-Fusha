import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/datasources/login_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';

import 'login_local_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences mockSharedPreference;
  late LoginLocalDataSourceImpl localDataSource;

  setUp(() {
    mockSharedPreference = MockSharedPreferences();
    localDataSource = LoginLocalDataSourceImpl(
      preferences: mockSharedPreference
    );
  });


  test('should call sharedPreferences to cached token', () async {
    const tLoginModel = LoginModel(data: 'token');

    //act
    localDataSource.cachedLoginData(tLoginModel);

    //assert
    const expectedJsonString = 'token';
    verify(mockSharedPreference.setString(Env.token, expectedJsonString));
  });


}
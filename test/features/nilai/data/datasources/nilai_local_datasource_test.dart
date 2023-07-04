import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/datasources/nilai_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/models/nilai_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NilaiLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = NilaiLocalDataSourceImpl(
      preferences: mockSharedPreferences
    );
  });

  final tNilai = NilaiModel.fromJson(jsonDecode(fixture('nilai.json')));

  test('should call shared to cached nilai data', () async {
    //act
    localDataSourceImpl.cachedNilai(tNilai);

    //assert
    verify(mockSharedPreferences.setString(
      Env.nilai, jsonEncode(tNilai.toJson()))
    );
    
  });

  test('should return cached nilai data when available', () async {
    //arrange
    when(mockSharedPreferences.getString(Env.nilai))
      .thenAnswer((_) => fixture('nilai.json'));
    
    //act
    final result = await localDataSourceImpl.getCachedNilai();

    //assert
    verify(mockSharedPreferences.getString(Env.nilai));
    expect(result, equals(tNilai));
  });

  test('should throw cache exception when there is no cached data', () async {
    //arrange
    when(mockSharedPreferences.getString(Env.nilai))
    .thenThrow(CacheException());

    //act
    final call = localDataSourceImpl.getCachedNilai;

    //assert
    expect(()=> call(), throwsA(const TypeMatcher<CacheException>()));
  });
}
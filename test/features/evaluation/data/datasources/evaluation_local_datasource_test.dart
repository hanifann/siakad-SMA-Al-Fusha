import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/datasources/evaluation_local_data_source.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_local_datasource_test.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late EvaluationLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = EvaluationLocalDataSourceImpl(
      preferences: mockSharedPreferences
    );
  });
  
  group('class', () {
    final tClass = ClassModel.fromJson(jsonDecode(fixture('class.json')));

    test('should call sharedPreference to cache data', () async {
      //act
      localDataSourceImpl.cachedKelas(tClass);
      //assert
      verify(mockSharedPreferences.setString(
        Env.classKey, 
        jsonEncode(tClass.toJson())
      ));
    });
    
    test('should return class data when available', () async{
      //arrange
      when(mockSharedPreferences.getString(Env.classKey))
        .thenAnswer((_) => fixture('class.json'));
      //act
      final result = await localDataSourceImpl.getCahchedKelas();
      //assert
      expect(result, equals(tClass));
    });
  });
}
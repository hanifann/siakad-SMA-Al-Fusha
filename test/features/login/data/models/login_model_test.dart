import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/login.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLoginModel = LoginModel(data: 'token');

  test('should be subclass of Login entity', () async {
    //assert
    expect(tLoginModel, isA<Login>());
  });

  group('fromJson', () {
    test('should return valid model', () {
      //arrange
      final jsonString = jsonDecode(fixture('login.json'));

      //act
      final result = LoginModel.fromJson(jsonString);

      //assert
      expect(result, equals(tLoginModel));
    });
  });

  group('toJson', () {
    test('should return json string from object', () {
      //act
      final result = tLoginModel.toJson();
      //assert
      final expectedMap = jsonDecode(fixture('login.json'));
      expect(result, equals(expectedMap));
    });
  });
}
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tClassData = ClassDataModel(id: '1', nama: 'nama');
  const tClass = ClassModel(data: [tClassData]);

  test('should be subclass of entities', () {
    //assert
    expect(tClassData, isA<ClassData>());
    expect(tClass, isA<Class>());
  });

  test('should return class object from json', () {
    //arrange
    final jsonString = jsonDecode(fixture('class.json'));
    //act
    final response = ClassModel.fromJson(jsonString);
    //assert
    expect(response, equals(tClass));
  });

  test('should return json from class object', () {
    //act
    final result = tClass.toJson();
    //assert
    final expectedJson = jsonDecode(fixture('class.json'));
    expect(result, equals(expectedJson));
  });
}
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/models/nilai_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNilaiDatumModel = NilaiDatumModel(
    nama: 'nama', 
    rph: 'rph', 
    pts: 'pts', 
    pat: 'pat', 
    jumlah: 'jumlah', 
    rataRata: 'rata'
  );

  const tNilaiModel = NilaiModel(data: [tNilaiDatumModel]);

  test('should be subclass on entities', () async {
    //assert
    expect(tNilaiDatumModel, isA<NilaiDatumModel>());
    expect(tNilaiModel, isA<NilaiModel>());
  });

  test('shold return nilai object from json', () async {
    //arrange
    final jsonString = jsonDecode(fixture('nilai.json'));
    
    //act
    final response = NilaiModel.fromJson(jsonString);

    //assert
    expect(response, equals(tNilaiModel));
  });

  test('should return json string from nilai object', () async {
    //act
    final response = tNilaiModel.toJson();

    //assert
    final expectedJson = jsonDecode(fixture('nilai.json'));
    expect(response, equals(expectedJson));
  });
}
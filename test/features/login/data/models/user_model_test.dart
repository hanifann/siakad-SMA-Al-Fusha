import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserDatumModel = UserDatumModel(
    id: '1', 
    nama: 'nama', 
    username: 'username', 
    role: '2', 
    idUsers: '13', 
    tempat: 'tempat', 
    tglLahir:null, 
    pendidikan: null, 
    tmk: null, 
    jabatan: 'jabatan', 
    alamat: 'alamat', 
    tgsTam: 'tgsTam',
    idKelas: 'idKelas'
  );

  const tUserModel = UserModel(data: [tUserDatumModel]);

  test('should be subclass of entity', () {
    //assert
    expect(tUserDatumModel, isA<UserDatum>());
    expect(tUserModel, isA<User>());
  });

  test('should return valid data model from json', () {
    //arrange
    final jsonString = jsonDecode(fixture('user.json'));

    //act
    final result = UserModel.fromJson(jsonString);

    //assert
    expect(result, equals(tUserModel));
  });

  test('should return json from data model', () {
    //act
    final result = tUserModel.toJson();

    //assert
    final expectedJson = jsonDecode(fixture('user.json'));
    expect(result, equals(expectedJson));
  });
}
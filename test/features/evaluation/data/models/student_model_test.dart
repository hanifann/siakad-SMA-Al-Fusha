import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/student_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  
  const tStudentData = StudentDatumModel(namaUser: 'namaUser', namaKelas: 'namaKelas');
  const tStudent = StudentModel(data: [tStudentData]);

  test('should be subclass on entities', () {
    //act
    expect(tStudentData, isA<StudentDatum>());
    expect(tStudent, isA<Student>());
  });

  test('should return list of student from json', () {
    //arrange
    final jsonString = jsonDecode(fixture('student.json'));

    //act
    final result = StudentModel.fromJson(jsonString);

    //assert
    expect(result, equals(tStudent));
  });

  test('should return json string from student object', () {
    //act
    final result = tStudent.toJson();

    //assert
    final expectedJson = jsonDecode(fixture('student.json'));
    expect(result, equals(expectedJson));
  });
}
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/models/schedule_model.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tScheduleData = ScheduleDataModel(
    guruPengampu: 'guruPengampu', 
    mapel: 'mapel', 
    kelas: 'kelas', 
    jam: 'jam', 
    jumlahJam: 'jumlahJam', 
    hari: 'hari'
  );

  const tSchedule = ScheduleModel(data: [tScheduleData]);

  test('should be subclass of entites', () {
    //assert
    expect(tScheduleData, isA<ScheduleData>());
    expect(tSchedule, isA<Schedule>());
  });

  test('should return schedule object from json', () {
    //arrange
    final jsonString = jsonDecode(fixture('schedule.json'));

    //act
    final result = ScheduleModel.fromJson(jsonString);

    //assert
    expect(result, equals(tSchedule));
  });

  test('should return json from schedule object', () {
    //act
    final result = tSchedule.toJson();

    //act
    final expectedJson = jsonDecode(fixture('schedule.json'));
    expect(result, equals(expectedJson));
  });
}
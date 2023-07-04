import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/models/announcement_model.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tAnnouncementDatumModel = AnnouncementDatumModel(
    id: '1', 
    tanggal: DateTime(2023, 07, 01), 
    judul: 'judul', 
    isiPengumuman: 'isi'
  );

  final tAnnouncementModel = AnnouncementModel(data: [tAnnouncementDatumModel]);


  test('should be subclass of entities', () {
    //assert
    expect(tAnnouncementDatumModel, isA<AnnouncementDatum>());
    expect(tAnnouncementModel, isA<Announcement>());
  });

  test('should return announcement model from json', () {
    //arrange
    final jsonString = jsonDecode(fixture('announcement.json'));

    //act
    final result = AnnouncementModel.fromJson(jsonString);

    //assert
    expect(result, equals(tAnnouncementModel));
  });

  test('should return json string from announcement model', () {
    //act
    final result = tAnnouncementModel.toJson();

    //assert
    final expectedJson = jsonDecode(fixture('announcement.json'));
    expect(result, equals(expectedJson));
  });
}
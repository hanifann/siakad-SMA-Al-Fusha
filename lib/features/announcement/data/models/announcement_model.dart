

import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';

class AnnouncementModel extends Announcement {
  const AnnouncementModel({required super.data});

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) => 
    AnnouncementModel(
        data: List<AnnouncementDatumModel>.from(
          json["data"].map((x) => AnnouncementDatumModel.fromJson(x))
        ),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map(
          (x) => AnnouncementDatumModel(
            id: x.id, 
            tanggal: x.tanggal, 
            judul: x.judul, 
            isiPengumuman: x.isiPengumuman
          ).toJson()
        )),
    };
  
}

class AnnouncementDatumModel extends AnnouncementDatum {
  const AnnouncementDatumModel({
    required super.id, required super.tanggal, 
    required super.judul, required super.isiPengumuman
  });

  factory AnnouncementDatumModel.fromJson(Map<String, dynamic> json) => 
    AnnouncementDatumModel(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        judul: json["judul"],
        isiPengumuman: json["isi_pengumuman"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal.toIso8601String(),
        "judul": judul,
        "isi_pengumuman": isiPengumuman,
    };
  
}
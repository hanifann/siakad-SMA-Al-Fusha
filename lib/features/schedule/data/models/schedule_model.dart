import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({required super.data});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        data: List<ScheduleDataModel>.from(json["data"].map((x) => ScheduleDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
          data.map((x) => ScheduleDataModel(
            guruPengampu: x.guruPengampu, 
            mapel: x.mapel, 
            kelas: x.kelas, 
            jam: x.jam, 
            jumlahJam: x.jumlahJam, 
            hari: x.hari
            ).toJson()
          )
        ),
    };
  
}

class ScheduleDataModel extends ScheduleData {
  const ScheduleDataModel({
    required super.guruPengampu, 
    required super.mapel, 
    required super.kelas, 
    required super.jam, 
    required super.jumlahJam, 
    required super.hari
  });

  factory ScheduleDataModel.fromJson(Map<String, dynamic> json) => ScheduleDataModel(
        guruPengampu: json["Guru Pengampu"],
        mapel: json["mapel"],
        kelas: json["kelas"],
        jam: json["jam"] ?? json['jam_mengajar'],
        jumlahJam: json["jumlah_jam"],
        hari: json["hari"],
    );

    Map<String, dynamic> toJson() => {
        "Guru Pengampu": guruPengampu,
        "mapel": mapel,
        "kelas": kelas,
        "jam": jam,
        "jumlah_jam": jumlahJam,
        "hari": hari,
    };
  
}
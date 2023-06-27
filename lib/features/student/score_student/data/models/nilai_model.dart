import 'package:siakad_sma_al_fusha/features/student/score_student/domain/entities/nilai.dart';

class NilaiModel extends Nilai {
  const NilaiModel({required super.data});
  
  factory NilaiModel.fromJson(Map<String, dynamic> json) => NilaiModel(
        data: List<NilaiDatumModel>.from(json["data"].map(
          (x) => NilaiDatumModel.fromJson(x)
        )),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
          data.map(
            (x) => NilaiDatumModel(
              nama: x.nama,
              rph: x.rph,
              pts: x.pts,
              pat: x.pat,
              jumlah: x.jumlah,
              rataRata: x.rataRata
            ).toJson()
          )
        ),
    };
}

class NilaiDatumModel extends NilaiDatum{
  const NilaiDatumModel({
    required super.nama, required super.rph, 
    required super.pts, required super.pat, 
    required super.jumlah, required super.rataRata
  });

  factory NilaiDatumModel.fromJson(Map<String, dynamic> json) => 
    NilaiDatumModel(
        nama: json["nama"],
        rph: json["rph"],
        pts: json["pts"],
        pat: json["pat"],
        jumlah: json["jumlah"],
        rataRata: json["rata_rata"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "rph": rph,
        "pts": pts,
        "pat": pat,
        "jumlah": jumlah,
        "rata_rata": rataRata,
    };
  
}
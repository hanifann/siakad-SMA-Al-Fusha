import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';

class LessonCodeModel extends LessonCode {
  const LessonCodeModel({required super.data});
  
  factory LessonCodeModel.fromJson(Map<String, dynamic> json) => LessonCodeModel(
        data: List<LessonCodeDataModel>.from(json["data"].map((x) => LessonCodeDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) =>LessonCodeDataModel(
          id: x.id, 
          nama: x.nama, 
          kode: x.kode, 
          namaGuru: x.namaGuru
        ).toJson())),
    };
}

class LessonCodeDataModel extends LessonCodeData {
  const LessonCodeDataModel({required super.id, required super.nama, required super.kode, required super.namaGuru});

  factory LessonCodeDataModel.fromJson(Map<String, dynamic> json) => LessonCodeDataModel(
        id: json["id"],
        nama: json["nama"],
        kode: json["kode"],
        namaGuru: json["nama_guru"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kode": kode,
        "nama_guru": namaGuru,
    };
  
}
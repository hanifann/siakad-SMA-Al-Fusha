import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/tahun_ajaran.dart';

class TahunAjaranModel extends TahunAjaran {
  const TahunAjaranModel({required super.data});

  factory TahunAjaranModel.fromJson(Map<String, dynamic> json) => TahunAjaranModel(
        data: List<TahunAjaranDataModel>.from(json["data"].map((x) => TahunAjaranDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) =>TahunAjaranDataModel(
          id: x.id, 
          nameThnAjaran: x.nameThnAjaran, 
          isActive: x.isActive
        ).toJson())),
    };
  
}

class TahunAjaranDataModel extends TahunAjaranData {
  const TahunAjaranDataModel({required super.id, required super.nameThnAjaran, required super.isActive});
  

  factory TahunAjaranDataModel.fromJson(Map<String, dynamic> json) => TahunAjaranDataModel(
        id: json["id"],
        nameThnAjaran: json["name_thn_ajaran"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_thn_ajaran": nameThnAjaran,
        "is_active": isActive,
    };
}
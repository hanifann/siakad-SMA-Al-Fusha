import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';

class ClassModel extends Class {
  const ClassModel({required super.data});

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        data: List<ClassDataModel>.from(json["data"].map((x) => ClassDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => 
          ClassDataModel(id: x.id, nama: x.nama).toJson()
        )),
    };
  
}

class ClassDataModel extends ClassData {
  const ClassDataModel({required super.id, required super.nama});
  
  factory ClassDataModel.fromJson(Map<String, dynamic> json) => ClassDataModel(
        id: json["id"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
    };
}
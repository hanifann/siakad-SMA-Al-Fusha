import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';

class StudentModel extends Student {
  const StudentModel({required super.data});

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        data: List<StudentDatumModel>.from(json["data"].map((x) => StudentDatumModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) =>StudentDatumModel(
          namaUser: x.namaUser, 
          namaKelas: x.namaKelas
        ).toJson())),
    };
  
}

class StudentDatumModel extends StudentDatum {
  const StudentDatumModel({required super.namaUser, required super.namaKelas});

  factory StudentDatumModel.fromJson(Map<String, dynamic> json) => StudentDatumModel(
        namaUser: json["nama_user"],
        namaKelas: json["nama_kelas"],
    );

    Map<String, dynamic> toJson() => {
        "nama_user": namaUser,
        "nama_kelas": namaKelas,
    };

}
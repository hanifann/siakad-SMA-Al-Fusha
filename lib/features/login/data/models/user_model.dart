import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.data});
  
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: List<UserDatumModel>.from(
          json["data"].map((x) => UserDatumModel.fromJson(x))
        ),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => 
          UserDatumModel(
            id: x.id, 
            nama: x.nama, 
            username: x.username, 
            role: x.role, 
            idUsers: x.idUsers, 
            tempat: x.tempat, 
            tglLahir: x.tglLahir, 
            pendidikan: x.pendidikan, 
            tmk: x.tmk, 
            jabatan: x.jabatan, 
            alamat: x.alamat, 
            tgsTam: x.tgsTam
          ).toJson()
        )),
    };
}

class UserDatumModel extends UserDatum {
  const UserDatumModel({
    required super.id, 
    required super.nama, 
    required super.username, 
    required super.role, 
    required super.idUsers, 
    required super.tempat, 
    required super.tglLahir, 
    required super.pendidikan, 
    required super.tmk, 
    required super.jabatan, 
    required super.alamat, 
    required super.tgsTam
  });

  factory UserDatumModel.fromJson(Map<String, dynamic> json) => UserDatumModel(
        id: json["id"],
        nama: json["nama"],
        username: json["username"],
        role: json["role"],
        idUsers: json["id_users"],
        tempat: json["tempat"],
        tglLahir: json['tgl_lahir'] == null ? null 
          : DateTime.parse(json["tgl_lahir"]),
        pendidikan: json["pendidikan"],
        tmk: json['tmk'] == null ? null : DateTime.parse(json["tmk"]),
        jabatan: json["jabatan"],
        alamat: json["alamat"],
        tgsTam: json["tgs_tam"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "username": username,
        "role": role,
        "id_users": idUsers,
        "tempat": tempat,
        "tgl_lahir": "${
          tglLahir?.year.toString().padLeft(4, '0')}-"
          "${tglLahir?.month.toString().padLeft(2, '0')}-"
          "${tglLahir?.day.toString().padLeft(2, '0')}",
        "pendidikan": pendidikan,
        "tmk": "${tmk?.year.toString().padLeft(4, '0')}-"
          "${tmk?.month.toString().padLeft(2, '0')}-"
          "${tmk?.day.toString().padLeft(2, '0')}",
        "jabatan": jabatan,
        "alamat": alamat,
        "tgs_tam": tgsTam,
    };
  
}
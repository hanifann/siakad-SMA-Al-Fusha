import 'package:equatable/equatable.dart';

class User extends Equatable{
    final List<UserDatum> data;

    const User({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class UserDatum extends Equatable{
    final String id;
    final String nama;
    final String username;
    final String role;
    final String idUsers;
    final String? tempat;
    final DateTime? tglLahir;
    final String? pendidikan;
    final DateTime? tmk;
    final String? jabatan;
    final String alamat;
    final String? tgsTam;
    final String? idKelas;

    const UserDatum({
        required this.id,
        required this.nama,
        required this.username,
        required this.role,
        required this.idUsers,
        required this.tempat,
        required this.tglLahir,
        required this.pendidikan,
        required this.tmk,
        required this.jabatan,
        required this.alamat,
        required this.tgsTam,
        required this.idKelas
    });
    
      @override
      List<Object?> get props => [
        id,
        nama,
        username,
        role,
        idUsers,
        tempat,
        tglLahir,
        pendidikan,
        tmk,
        jabatan,
        alamat,
        tgsTam,
        idKelas
      ];

}
import 'package:equatable/equatable.dart';

class Student extends Equatable{
    final List<StudentDatum> data;

    const Student({
        required this.data,
    });
    
      @override
      List<Object?> get props => [data];

}

class StudentDatum extends Equatable{
    final String namaUser;
    final String namaKelas;

    const StudentDatum({
        required this.namaUser,
        required this.namaKelas,
    });
    
      @override
      List<Object?> get props => [
        namaUser,
        namaKelas
      ];

}

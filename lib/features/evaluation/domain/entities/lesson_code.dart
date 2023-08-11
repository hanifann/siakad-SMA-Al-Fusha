import 'package:equatable/equatable.dart';

class LessonCode extends Equatable{
    final List<LessonCodeData> data;

    const LessonCode({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class LessonCodeData extends Equatable{
    final String id;
    final String nama;
    final String kode;
    final String namaGuru;

    const LessonCodeData({
        required this.id,
        required this.nama,
        required this.kode,
        required this.namaGuru,
    });
    
      @override
      List<Object?> get props => [
        id,
        nama,
        kode,
        namaGuru
      ];

}

import 'package:equatable/equatable.dart';

class Schedule extends Equatable{
    final List<ScheduleData> data;

    const Schedule({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class ScheduleData extends Equatable{
    final String guruPengampu;
    final String mapel;
    final String kelas;
    final String jam;
    final String jumlahJam;
    final String hari;

    const ScheduleData({
        required this.guruPengampu,
        required this.mapel,
        required this.kelas,
        required this.jam,
        required this.jumlahJam,
        required this.hari,
    });
    
      @override
      List<Object?> get props => [
        guruPengampu,
        mapel,
        kelas,
        jam,
        jumlahJam,
        hari
      ];

}

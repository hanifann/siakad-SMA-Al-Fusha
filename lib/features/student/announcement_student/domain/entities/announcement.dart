import 'package:equatable/equatable.dart';

class Announcement extends Equatable{
    final List<AnnouncementDatum> data;

    const Announcement({
        required this.data,
    });
    
      @override
      List<Object?> get props => [data];

}

class AnnouncementDatum extends Equatable{
    final String id;
    final DateTime tanggal;
    final String judul;
    final String isiPengumuman;

    const AnnouncementDatum({
        required this.id,
        required this.tanggal,
        required this.judul,
        required this.isiPengumuman,
    });
    
      @override
      List<Object?> get props => [
        id,
        tanggal,
        judul,
        isiPengumuman
      ];

}

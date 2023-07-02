class Announcement {
    final List<AnnouncementDatum> data;

    Announcement({
        required this.data,
    });

}

class AnnouncementDatum {
    final String id;
    final DateTime tanggal;
    final String judul;
    final String isiPengumuman;

    AnnouncementDatum({
        required this.id,
        required this.tanggal,
        required this.judul,
        required this.isiPengumuman,
    });

}

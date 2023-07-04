import 'package:equatable/equatable.dart';

class Nilai extends Equatable{
    final List<NilaiDatum> data;

    const Nilai({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data,
      ];
}

class NilaiDatum extends Equatable {
    final String nama;
    final String rph;
    final String pts;
    final String pat;
    final String jumlah;
    final String rataRata;

    const NilaiDatum({
        required this.nama,
        required this.rph,
        required this.pts,
        required this.pat,
        required this.jumlah,
        required this.rataRata,
    });
    
      @override
      List<Object?> get props => [
        nama,
        rph,
        pts,
        pat,
        jumlah,
        rataRata
      ];

}

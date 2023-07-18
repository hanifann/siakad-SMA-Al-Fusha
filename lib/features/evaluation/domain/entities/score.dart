import 'package:equatable/equatable.dart';

class Score extends Equatable{
    final ScoreData data;

    const Score({
        required this.data,
    });
    
      @override
      List<Object?> get props => [
        data
      ];

}

class ScoreData extends Equatable{
    final String idUsers;
    final String kdPelajaran;
    final String rph;
    final String pts;
    final String pat;
    final int jumlah;
    final double rataRata;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int id;

    const ScoreData({
        required this.idUsers,
        required this.kdPelajaran,
        required this.rph,
        required this.pts,
        required this.pat,
        required this.jumlah,
        required this.rataRata,
        required this.createdAt,
        required this.updatedAt,
        required this.id,
    });
    
      @override
      List<Object?> get props => [
        idUsers,
        kdPelajaran,
        rph,
        pts,
        pat,
        jumlah,
        rataRata,
        createdAt,
        updatedAt,
        id
      ];

}

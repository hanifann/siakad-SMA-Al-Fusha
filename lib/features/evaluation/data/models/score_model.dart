import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/score.dart';

class ScoreModel extends Score{
  const ScoreModel({required super.data});

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        data: ScoreDataModel.fromJson(json["data"]),
    );
  
}

class ScoreDataModel extends ScoreData {
  const ScoreDataModel({
    required super.idUsers, 
    required super.kdPelajaran, 
    required super.rph, 
    required super.pts, 
    required super.pat, 
    required super.jumlah, 
    required super.rataRata, 
    required super.createdAt, 
    required super.updatedAt, 
    required super.id
  });
  
  factory ScoreDataModel.fromJson(Map<String, dynamic> json) => ScoreDataModel(
        idUsers: json["id_users"],
        kdPelajaran: json["kd_pelajaran"],
        rph: json["rph"],
        pts: json["pts"],
        pat: json["pat"],
        jumlah: json["jumlah"],
        rataRata: json["rata_rata"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
    );
}
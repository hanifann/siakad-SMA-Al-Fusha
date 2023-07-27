import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/models/nilai_model.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/models/tahun_ajaran_model.dart';

abstract class NilaiLocalDataSource {
  Future<void>? cachedNilai(NilaiModel nilai);
  Future<NilaiModel>? getCachedNilai();
  Future<void>? cachedTahunAjaran(TahunAjaranModel tahunAjaran);
  Future<TahunAjaranModel>? getCahcedTahunAjaran();
}

class NilaiLocalDataSourceImpl implements NilaiLocalDataSource{
  final SharedPreferences preferences;

  const NilaiLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? cachedNilai(NilaiModel nilai) {
    return preferences.setString(
      Env.nilai,
      jsonEncode(nilai.toJson())
    );
  }

  @override
  Future<NilaiModel>? getCachedNilai() async {
    final jsonString = preferences.getString(Env.nilai);
    if(jsonString != null){
      return Future.value(NilaiModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
  @override
  Future<void>? cachedTahunAjaran(TahunAjaranModel tahunAjaran) {
    return preferences.setString(
      Env.tahunKey,
      jsonEncode(tahunAjaran.toJson())
    );
  }
  
  @override
  Future<TahunAjaranModel>? getCahcedTahunAjaran() {
    final jsonString = preferences.getString(Env.tahunKey);
    if(jsonString != null){
      return Future.value(TahunAjaranModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}
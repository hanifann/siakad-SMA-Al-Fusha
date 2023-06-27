import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/data/models/nilai_model.dart';

abstract class NilaiLocalDataSource {
  Future<void>? cachedNilai(NilaiModel nilai);
  Future<NilaiModel>? getCachedNilai();
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
  
}
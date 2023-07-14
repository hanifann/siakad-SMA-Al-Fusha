import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';

abstract class EvaluationLocalDataSource {
  Future<void>? cachedKelas(ClassModel classModel);
  Future<ClassModel>? getCahchedKelas();
}

class EvaluationLocalDataSourceImpl implements EvaluationLocalDataSource {
  final SharedPreferences preferences;

  EvaluationLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? cachedKelas(ClassModel classModel) {
    return preferences.setString(
      Env.classKey,
      jsonEncode(classModel.toJson())
    );
  }

  @override
  Future<ClassModel>? getCahchedKelas() {
    final jsonString = preferences.getString(Env.classKey);
    if(jsonString != null){
      return Future.value(ClassModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}


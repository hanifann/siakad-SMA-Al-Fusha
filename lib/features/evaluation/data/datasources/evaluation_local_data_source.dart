import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/lesson_code_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/student_model.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';

abstract class EvaluationLocalDataSource {
  Future<void>? cachedKelas(ClassModel classModel);
  Future<ClassModel>? getCahchedKelas();
  Future<void>? chachedStudent(StudentModel studentModel);
  Future<StudentModel>? getChachedStudent();
  Future<LessonCode>? getCachedLessonCode();
  Future<void>? cachedLessonCode(LessonCodeModel code);
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
  
  @override
  Future<void>? chachedStudent(StudentModel studentModel) {
    return preferences.setString(
      Env.studentKey,
      jsonEncode(studentModel.toJson())
    );
  }
  
  @override
  Future<StudentModel>? getChachedStudent() {
    final jsonString = preferences.getString(Env.studentKey);
    if(jsonString != null){
      return Future.value(StudentModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
  @override
  Future<void>? cachedLessonCode(LessonCodeModel code) {
    return preferences.setString(
      Env.codeKey,
      jsonEncode(code.toJson())
    );
  }
  
  @override
  Future<LessonCode>? getCachedLessonCode() {
    final jsonString = preferences.getString(Env.codeKey);
    if(jsonString != null){
      return Future.value(LessonCodeModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  
}


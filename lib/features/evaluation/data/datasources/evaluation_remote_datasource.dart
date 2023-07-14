
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/data/models/class_model.dart';

abstract class EvaluationRemoteDataSource {
  Future<ClassModel>? getALlClass();
}

class EvaluationRemoteDataSourceImpl implements EvaluationRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  EvaluationRemoteDataSourceImpl({
    required this.client, 
    required this.preferences
  });

  @override
  Future<ClassModel>? getALlClass() async {
    final response = await client.get(
      Uri.https(Env.url, '/api/kelas'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}',
      }
    );

    if(response.statusCode == 200){
      return ClassModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
}
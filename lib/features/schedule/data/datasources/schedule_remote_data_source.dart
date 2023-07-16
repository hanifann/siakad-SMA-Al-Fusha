import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/models/schedule_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<ScheduleModel>? getSchedule(String id, String day);
  Future<ScheduleModel>? getTeachingSchedule(String id);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  ScheduleRemoteDataSourceImpl({required this.client, required this.preferences});

  @override
  Future<ScheduleModel>? getSchedule(String id, String day) async {
    final response = await client.get(
      Uri.https(Env.url, '/api/jadwal_pelajaran/$id/$day'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}',
      }
    );

    if(response.statusCode == 200){
      return ScheduleModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
  @override
  Future<ScheduleModel>? getTeachingSchedule(String id) async {
    final response = await client.get(
      Uri.https(Env.url, '/api/jadwal_mengajar/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}',
      }
    );

    if(response.statusCode == 200){
      return ScheduleModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
}
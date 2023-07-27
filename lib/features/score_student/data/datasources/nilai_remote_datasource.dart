import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/models/nilai_model.dart';
import 'package:siakad_sma_al_fusha/features/score_student/data/models/tahun_ajaran_model.dart';

abstract class NilaiRemoteDataSource {
  Future<NilaiModel>? getNilai(String id, String tahunAjaranId);
  Future<TahunAjaranModel>? getTahunAjaran();
}

class NilaiRemoteDataSourceImpl implements NilaiRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  const NilaiRemoteDataSourceImpl({
    required this.client, 
    required this.preferences
  });

  @override
  Future<NilaiModel>? getNilai(String id, String tahunAjaranId) async {
    final response = await client.get(
      Uri.https(Env.url, '/api/nilai_by_siswa/$id/$tahunAjaranId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}',
      }
    );

    if(response.statusCode == 200){
      return NilaiModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
  @override
  Future<TahunAjaranModel>? getTahunAjaran() async {
    final response = await client.get(
      Uri.https(Env.url, '/api/thn_ajaran'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}',
      }
    );

    if(response.statusCode == 200){
      return TahunAjaranModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
}
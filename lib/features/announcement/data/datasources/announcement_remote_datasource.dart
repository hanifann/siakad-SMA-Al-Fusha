import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/models/announcement_model.dart';

abstract class AnnouncementRemoteDataSource {
  Future<AnnouncementModel>? getAnnouncement();
}

class AnnouncementRemoteDataSourceImpl implements AnnouncementRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  const AnnouncementRemoteDataSourceImpl({
    required this.client, 
    required this.preferences
  });

  @override
  Future<AnnouncementModel>? getAnnouncement() async {
    final response = await client.get(
      Uri.https(Env.url, '/api/pengumuman'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}',
      }
    );

    if(response.statusCode == 200){
      return AnnouncementModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
}
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/data/models/announcement_model.dart';

abstract class AnnouncementLocalDataSource {
  Future<void>? cachedAnnouncement(AnnouncementModel announcement);
  Future<AnnouncementModel>? getCachedAnnouncement();
}

class AnnouncementLocalDataSourceImpl implements AnnouncementLocalDataSource {
  final SharedPreferences preferences;

  AnnouncementLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? cachedAnnouncement(AnnouncementModel announcement) {
    return preferences.setString(
      Env.announcement,
      jsonEncode(announcement.toJson())
    );
  }

  @override
  Future<AnnouncementModel>? getCachedAnnouncement() {
    final result = preferences.getString(Env.announcement);
    if(result != null){
      return Future.value(AnnouncementModel.fromJson(jsonDecode(result)));
    } else {
      throw CacheException();
    }
  }
  
}
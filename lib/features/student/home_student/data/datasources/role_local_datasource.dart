import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';

abstract class RoleLocalDataSource {
  Future<UserModel>? getCachedRole();
}

class RoleLocalDataSourceImpl implements RoleLocalDataSource {
  final SharedPreferences preferences;

  RoleLocalDataSourceImpl(this.preferences);

  @override
  Future<UserModel>? getCachedRole() async {
    final result = preferences.getString(Env.user);
    if(result!= null){
      return Future.value(UserModel.fromJson(jsonDecode(result)));
    } else {
      throw CacheException();
    }
  }
  
}
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';

abstract class LoginLocalDataSource {
  Future<void>? cachedLoginData(LoginModel login);
  Future<void>? cachedUserData(UserModel user);
  Future<UserModel>? getCachedUserData();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences preferences;

  LoginLocalDataSourceImpl({required this.preferences});

  @override
  Future<void>? cachedLoginData(LoginModel login) {
    return preferences.setString(
      Env.token,
      login.data
    );
  }
  
  @override
  Future<void>? cachedUserData(UserModel user) {
    return preferences.setString(Env.user, jsonEncode(user.toJson()));
}

  @override
  Future<UserModel>? getCachedUserData() {
    final jsonString = preferences.getString(Env.user);
    if(jsonString != null){
      return Future.value(UserModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
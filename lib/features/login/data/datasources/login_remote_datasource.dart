import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> postLogin({
    required String username, 
    required String password
  });

  Future<UserModel> getUser();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Client client;
  final SharedPreferences preferences;

  LoginRemoteDataSourceImpl({required this.client, required this.preferences});

  @override
  Future<LoginModel> postLogin({
    required String username, 
    required String password
  }) async {
    final response = await client.post(
      Uri.https(Env.url, '/api/login'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'username': username,
        'password': password
      }
    );
    if(response.statusCode == 200){
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
  
  @override
  Future<UserModel> getUser() async {
    final response = await client.get(
      Uri.https(Env.url, '/api/me'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString(Env.token)}'
      },
    );
    if(response.statusCode == 200){
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(
        error: ErrorModel.fromJson(jsonDecode(response.body))
      );
    }
  }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/data/models/login_model.dart';

abstract class LoginLocalDataSource {
  Future<void>? cachedLoginData(LoginModel login);
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
}
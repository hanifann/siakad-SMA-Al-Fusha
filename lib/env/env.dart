import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'URL')
  static String url = _Env.url;
  @EnviedField(obfuscate: true, varName: 'TOKEN_KEY')
  static String token = _Env.token;
  @EnviedField(obfuscate: true, varName: 'USER_KEY')
  static String user = _Env.user;
  @EnviedField(obfuscate: true, varName: 'NILAI_KEY')
  static String nilai = _Env.nilai;
}

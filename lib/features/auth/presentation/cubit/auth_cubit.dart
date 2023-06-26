import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.preferences) : super(AuthInitial());

  final SharedPreferences preferences;

  void checkAuthenticationStatus() {
    final status = preferences.containsKey(Env.token);
    if(status){
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthorized());
    }
  }
}

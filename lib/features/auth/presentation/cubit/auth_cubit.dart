import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/env/env.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/get_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.preferences, this.useCase) : super(AuthInitial());

  final SharedPreferences preferences;
  final GetUserUseCase useCase;

  void checkAuthenticationStatus() {
    final status = preferences.containsKey(Env.user);
    if(status){
      getUserData();
    } else {
      emit(AuthUnauthorized());
    }
  }

  void getUserData() async {
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(AuthUnauthorized()), 
      (r) => emit(AuthAuthenticated(r.data[0].role))
    );
  }
}

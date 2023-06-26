import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/post_login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.useCase) : super(LoginInitial()) {
    on<PostLoginEvent>(_onPostLoginEvent);
  }

  final PostLoginUseCase useCase;

  void _onPostLoginEvent(
    PostLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await useCase(
      LoginParams(username: event.username, password: event.password)
    );
    result!.fold(
      (l) {
        emit(LoginFailed(ErrorModel(message: l.message)));
      }, 
      (r) {
        emit(LoginSucceed());
      }
    );
  }
}

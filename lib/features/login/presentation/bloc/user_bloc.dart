import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/get_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.useCase) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUserEvent);
  }

  final GetUserUseCase useCase;

  void _onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) {
        emit(UserFailed(ErrorModel(message: l.message)));
      }, 
      (r) {
        emit(UserSucceed(r));
      }
    );
  }
}

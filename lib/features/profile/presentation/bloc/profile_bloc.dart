import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.useCase, this.preferences) 
    : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  final GetRoleUseCase useCase;
  final SharedPreferences preferences;

  void _onGetProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(ProfileFailed(ErrorModel(message: l.message))), 
      (r) => emit(ProfileLoaded(r))
    );
  }

  void _onLogoutEvent(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await preferences.clear();
    emit(LogoutSuccess());
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.useCase) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfileEvent);
  }

  final GetRoleUseCase useCase;

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
}

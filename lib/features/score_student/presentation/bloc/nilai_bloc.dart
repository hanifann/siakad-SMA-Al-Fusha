import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/usecases/get_nilai_usecase.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiBloc(this.useCase, this.roleUseCase) : super(NilaiInitial()) {
    on<GetNilaiEvent>(_onGetNilaiEvent);
    on<GetUserIdEvent>(_onGetUSerIdEvent);
  }

  final GetNilasiUseCase useCase;
  final GetRoleUseCase roleUseCase;

  void _onGetNilaiEvent(
    GetNilaiEvent event,
    Emitter<NilaiState> emit,
  ) async {
    emit(NilaiLoading());
    final result = await useCase(NilaiParams(event.id));
    result!.fold(
      (l) => emit(NilaiFailed(ErrorModel(message: l.message))), 
      (r) => emit(NilaiLoaded(r))
    );
  }

  void _onGetUSerIdEvent(
    GetUserIdEvent event,
    Emitter<NilaiState> emit,
  ) async {
    emit(NilaiLoading());
    final userId = await roleUseCase(NoParams());
    userId!.fold(
      (l) => emit(const NilaiFailed(ErrorModel())),
      (r) => emit(UserDataLoaded(r))
    );
  }

}

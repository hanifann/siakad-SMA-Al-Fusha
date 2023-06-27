import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/usecases/get_nilai_usecase.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  NilaiBloc(this.useCase) : super(NilaiInitial()) {
    on<GetNilaiEvent>(_onGetNilaiEvent);
  }

  final GetNilasiUseCase useCase;

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

}

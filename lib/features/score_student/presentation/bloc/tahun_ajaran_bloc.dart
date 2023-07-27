import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/tahun_ajaran.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/usecases/get_tahun_ajaran_usecase.dart';

part 'tahun_ajaran_event.dart';
part 'tahun_ajaran_state.dart';

class TahunAjaranBloc extends Bloc<TahunAjaranEvent, TahunAjaranState> {
  TahunAjaranBloc({required this.useCase}) : super(TahunAjaranInitial()) {
    on<GetTahunAjaranEvent>(_onGetTahunAjaran);
  }

  final GetTahunAjaranUseCase useCase;

  void _onGetTahunAjaran(
    GetTahunAjaranEvent event,
    Emitter<TahunAjaranState> emit,
  ) async {
    emit(TathunAjaranLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(TahunajaranFailed(ErrorModel(message: l.message))), 
      (r) => emit(TahunAjaranLoaded(r))
    );
  }
}

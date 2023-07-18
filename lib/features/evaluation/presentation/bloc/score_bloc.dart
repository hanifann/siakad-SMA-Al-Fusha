import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/post_score_usecase.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc({required this.useCase}) : super(ScoreInitial()) {
    on<PostScoreEvent>(_onPostEventUseCase);
  }

  final PostScoreUseCase useCase;

  void _onPostEventUseCase (
    PostScoreEvent event,
    Emitter<ScoreState> emit,
  ) async {
    emit(ScoreLoading());
    final result = await useCase(
      ScoreParam(
        idUser: event.idUser,
        lessonCode: event.lessonCode, 
        rph: event.rph, 
        pts: event.pts, 
        pat: event.pat
      )
    );
    result!.fold(
      (l) => emit(ScoreFailed(ErrorModel(message: l.message))), 
      (r) => emit(ScoreSuccess())
    );
  }
}

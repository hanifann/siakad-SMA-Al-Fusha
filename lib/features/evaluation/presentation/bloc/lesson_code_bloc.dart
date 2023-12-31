import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_lesson_code_usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_student_by_class_usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';

part 'lesson_code_event.dart';
part 'lesson_code_state.dart';

class LessonCodeBloc extends Bloc<LessonCodeEvent, LessonCodeState> {
  LessonCodeBloc({
    required this.useCase, 
    required this.getClassIdUseCase
  }) : super(LessonCodeInitial()) {
    on<GetLessonCodeEvent>(_onGetLessonCodeEvent);
    on<GetClassIdEvent>(_onGetClassIdEvent);
  }

  final GetLessonCodeUseCase useCase;
  final GetRoleUseCase getClassIdUseCase;

  void _onGetLessonCodeEvent(
    GetLessonCodeEvent event,
    Emitter<LessonCodeState> emit,
  ) async {
    emit(LessonCodeLoading());
    final result = await useCase(StudentParam(event.classId));
    result!.fold(
      (l) => emit(LessonCodeFailed(ErrorModel(message: l.message))), 
      (r) => emit(LessonCodeLoaded(r))
    );
  }

  void _onGetClassIdEvent(
    GetClassIdEvent event,
    Emitter<LessonCodeState> emit,
  ) async {
    emit(LessonCodeLoading());
    final result = await getClassIdUseCase(NoParams());
    result!.fold(
      (l) => emit(LessonCodeFailed(ErrorModel(message: l.message))), 
      (r) => emit(LessonCodeClassIdLoaded(r.data[0].idKelas!))
    );
  }
}

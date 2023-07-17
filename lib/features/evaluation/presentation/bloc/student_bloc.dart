import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_student_by_class_usecase.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({required this.useCase}) : super(StudentInitial()) {
    on<GetStudentByClassEvent>(_onGetStudentByClassEvent);
  }

  final GetStudentByClassUseCase useCase;

  void _onGetStudentByClassEvent(
    GetStudentByClassEvent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    final result = await useCase(StudentParam(event.classId));
    result!.fold(
      (l) => emit(StudentFailed(ErrorModel(message: l.message))), 
      (r) => emit(StudentLoaded(r))
    );
  }
}

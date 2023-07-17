import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_student_by_class_usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({
    required this.useCase, 
    required this.roleUseCase
  }) : super(StudentInitial()) {
    on<GetStudentByClassEvent>(_onGetStudentByClassEvent);
    on<GetTokenEvent>(_onGetTokenEvent);
  }

  final GetStudentByClassUseCase useCase;
  final GetRoleUseCase roleUseCase;

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

    void _onGetTokenEvent(
    GetTokenEvent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    final result = await roleUseCase(NoParams());
    result!.fold(
      (l) => emit(StudentFailed(ErrorModel(message: l.message))), 
      (r) => emit(TokenLoaded(r))
    );
  }
}

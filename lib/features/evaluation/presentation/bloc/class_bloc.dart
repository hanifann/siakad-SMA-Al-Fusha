import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_all_class_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({
    required this.classUseCase, 
  }) : super(ClassInitial()) {
    on<GetAllClassEvent>(_getAllClassEvent);
  }

  final GetAllClassUseCase classUseCase;

  void _getAllClassEvent(
    GetAllClassEvent event,
    Emitter<ClassState> emit,
  ) async {
    emit(ClassLoading());
    final result = await classUseCase(NoParams());
    result!.fold(
      (l) => emit(ClassFailed(ErrorModel(message: l.message))), 
      (r) => emit(ClassLoaded(r))
    );
  }
}

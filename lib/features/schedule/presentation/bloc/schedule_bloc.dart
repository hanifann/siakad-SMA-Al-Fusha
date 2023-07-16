import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/home/domain/usecases/get_role_usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/usecases/get_teaching_schedule_usecase.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required this.useCase,
    required this.roleUseCase,
    required this.teachingScheduleUseCase
  }) : super(ScheduleInitial()) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
    on<GetTeachingScheduleEvent>(_onGetTeachingScheduleEvent);
    on<GetUserIdEvent>(_onGetUSerIdEvent);
  }

  final GetScheduleUseCase useCase;
  final GetRoleUseCase roleUseCase;
  final GetTeachingScheduleUseCase teachingScheduleUseCase;

  void _onGetScheduleEvent(
    GetScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    final result = await useCase(
      ScheduleParam(id: event.id, day: event.day)
    );

    result!.fold(
      (l) => emit(ScheduleFailed(ErrorModel(message: l.message))), 
      (r) => emit(ScheduleLoaded(r))
    );
  }

  void _onGetTeachingScheduleEvent(
    GetTeachingScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    final result = await teachingScheduleUseCase(
      TeachingScheduleParam(event.id)
    );

    result!.fold(
      (l) => emit(ScheduleFailed(ErrorModel(message: l.message))), 
      (r) => emit(ScheduleLoaded(r))
    );
  }

  void _onGetUSerIdEvent(
    GetUserIdEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    final userId = await roleUseCase(NoParams());
    userId!.fold(
      (l) => emit(const ScheduleFailed(ErrorModel())),
      (r) => emit(UserDataLoaded(r))
    );
  }
}

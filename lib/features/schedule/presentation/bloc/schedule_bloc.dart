import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/usecases/get_schedule_usecase.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({required this.useCase}) : super(ScheduleInitial()) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
  }

  final GetScheduleUseCase useCase;

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
}

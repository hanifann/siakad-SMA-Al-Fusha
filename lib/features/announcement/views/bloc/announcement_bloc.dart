import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/model/error.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/usecases/get_announcement_usecase.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  AnnouncementBloc({required this.useCase}) : super(AnnouncementInitial()) {
    on<GetAnnouncementEvent>(_onGetAnnouncementEvent);
  }

  final GetAnnouncementUseCase useCase;

  void _onGetAnnouncementEvent(
    GetAnnouncementEvent event,
    Emitter<AnnouncementState> emit,
  ) async {
    emit(AnnouncementLoading());
    final result = await useCase(NoParams());
    result!.fold(
      (l) => emit(AnnouncementFailed(ErrorModel(message: l.message))), 
      (r) => emit(AnnouncementLoaded(r))
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/repositories/schedule_repository.dart';

class GetScheduleUseCase extends UseCase<Schedule, ScheduleParam> {
  final ScheduleRepository repository;

  GetScheduleUseCase({required this.repository});

  @override
  Future<Either<Failure, Schedule>?> call(params) async {
    return repository.getSchedule(params.id, params.day);
  }
}

class ScheduleParam extends Equatable {
  final String id;
  final String day;

  const ScheduleParam({required this.id, required this.day});

  @override
  List<Object?> get props => [
    id,
    day
  ];
}
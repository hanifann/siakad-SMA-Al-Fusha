import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/repositories/schedule_repository.dart';

class GetTeachingScheduleUseCase extends UseCase<Schedule, TeachingScheduleParam> {
  final ScheduleRepository repository;

  GetTeachingScheduleUseCase(this.repository);

  @override
  Future<Either<Failure, Schedule>?> call(params) async {
    return repository.getTeachingSchedule(params.id);
  }
  
}

class TeachingScheduleParam extends Equatable{
  final String id;

  const TeachingScheduleParam(this.id);

  @override
  List<Object?> get props => [
    id
  ];
}
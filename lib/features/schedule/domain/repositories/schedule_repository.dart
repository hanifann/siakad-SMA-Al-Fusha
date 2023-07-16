import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, Schedule>>? getSchedule(String id, String day);
  Future<Either<Failure, Schedule>>? getTeachingSchedule(String id);
}
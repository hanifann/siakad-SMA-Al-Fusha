import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';

abstract class EvaluationRepository {
  Future<Either<Failure, Class>>? getAllClass();
}
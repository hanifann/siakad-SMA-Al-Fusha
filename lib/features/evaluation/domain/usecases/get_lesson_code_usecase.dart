import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';

class GetLessonCodeUseCase extends UseCase<LessonCode, NoParams> {
  final EvaluationRepository repository;

  GetLessonCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, LessonCode>?> call(NoParams params) async {
    return repository.getLessonCode();
  }
  
}
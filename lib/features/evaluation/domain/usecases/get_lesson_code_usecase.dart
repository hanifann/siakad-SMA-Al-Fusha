import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_student_by_class_usecase.dart';

class GetLessonCodeUseCase extends UseCase<LessonCode, StudentParam> {
  final EvaluationRepository repository;

  GetLessonCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, LessonCode>?> call(StudentParam params) async {
    return repository.getLessonCode(params.classId);
  }
  
}
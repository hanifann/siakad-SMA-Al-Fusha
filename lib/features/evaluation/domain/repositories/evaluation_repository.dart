import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/score.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';

abstract class EvaluationRepository {
  Future<Either<Failure, Class>>? getAllClass();
  Future<Either<Failure, Student>>? getStudentByClass(String classId);
  Future<Either<Failure, LessonCode>>? getLessonCode();
  Future<Either<Failure, Score>>? postScore({
    required String lessonCode,
    required String rph,
    required String pts,
    required String pat
  });
}
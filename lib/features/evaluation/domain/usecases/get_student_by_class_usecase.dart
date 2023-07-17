import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';

class GetStudentByClassUseCase extends UseCase<Student, StudentParam> {
  final EvaluationRepository repository;

  GetStudentByClassUseCase({required this.repository});

  @override
  Future<Either<Failure, Student>?> call(params) async {
    return repository.getStudentByClass(params.classId);
  }
  
}

class StudentParam extends Equatable{
  final String classId;

  const StudentParam(this.classId);

  @override
  List<Object?> get props => [
    classId
  ];
}
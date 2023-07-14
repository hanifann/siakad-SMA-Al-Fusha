import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';

class GetAllClassUseCase extends UseCase<Class, NoParams> {
  final EvaluationRepository repository;

  GetAllClassUseCase({required this.repository});

  @override
  Future<Either<Failure, Class>?> call(NoParams params) async {
    return repository.getAllClass();
  }
}
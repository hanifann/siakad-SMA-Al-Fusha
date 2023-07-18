import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';

import '../entities/score.dart';

class PostScoreUseCase extends UseCase<Score, ScoreParam> {
  final EvaluationRepository repository;

  PostScoreUseCase({required this.repository});

  @override
  Future<Either<Failure, Score>?> call(params) async {
    return repository.postScore(
      lessonCode: params.lessonCode, 
      rph: params.rph, 
      pts: params.pts, 
      pat: params.pat
    );
  }
  
}

class ScoreParam extends Equatable{
  final String lessonCode;
  final String rph;
  final String pts;
  final String pat;

  const ScoreParam({
    required this.lessonCode, 
    required this.rph, 
    required this.pts, 
    required this.pat
  });

  @override
  List<Object?> get props => [
    lessonCode,
    rph,
    pts,
    pat
  ];
}
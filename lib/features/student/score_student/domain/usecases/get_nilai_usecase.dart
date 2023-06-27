import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/repositories/nilai_repository.dart';

class GetNilasiUseCase extends UseCase<Nilai, NilaiParams> {
  final NilaiRepository repository;

  GetNilasiUseCase({required this.repository});


  @override
  Future<Either<Failure, Nilai>?> call(params) async {
    return repository.getNilai(params.id);
  }
  
}

class NilaiParams extends Equatable{
  final String id;

  const NilaiParams(this.id);

  @override
  List<Object?> get props => [
    id
  ];
}
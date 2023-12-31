import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/repositories/nilai_repository.dart';

class GetNilasiUseCase extends UseCase<Nilai, NilaiParams> {
  final NilaiRepository repository;

  GetNilasiUseCase({required this.repository});


  @override
  Future<Either<Failure, Nilai>?> call(params) async {
    return repository.getNilai(params.id, params.tahunAjaranId);
  }
  
}

class NilaiParams extends Equatable{
  final String id;
  final String tahunAjaranId;

  const NilaiParams(this.id, this.tahunAjaranId);

  @override
  List<Object?> get props => [
    id,
    tahunAjaranId
  ];
}
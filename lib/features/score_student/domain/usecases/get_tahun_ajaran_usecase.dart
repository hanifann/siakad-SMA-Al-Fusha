import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/tahun_ajaran.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/repositories/nilai_repository.dart';

class GetTahunAjaranUseCase extends UseCase<TahunAjaran, NoParams> {
  final NilaiRepository repository;

  GetTahunAjaranUseCase({required this.repository});

  @override
  Future<Either<Failure, TahunAjaran>?> call(NoParams params) async {
    return repository.getTahunAjaran();
  }
  
}
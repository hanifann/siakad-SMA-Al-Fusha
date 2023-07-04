import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/nilai.dart';

abstract class NilaiRepository {
  Future<Either<Failure, Nilai>>? getNilai(String id);
}
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

abstract class RoleRepository {
  Future<Either<Failure, User>>? getRole();
}
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/login.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>>? postLogin(
    String username,
    String password
  );

  Future<Either<Failure, User>>? getUser();
}
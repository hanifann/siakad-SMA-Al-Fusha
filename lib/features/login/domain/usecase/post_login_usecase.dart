import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/login.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';

class PostLoginUseCase extends UseCase<Login, LoginParams> {
  final LoginRepository repository;

  PostLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, Login>?> call(params) async {
    return repository.postLogin(params.username, params.password);
  }
  
}

class LoginParams extends Equatable{
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [
    username,
    password
  ];
}
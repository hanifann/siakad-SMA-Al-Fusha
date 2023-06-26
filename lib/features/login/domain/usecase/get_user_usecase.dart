import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  final LoginRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<Either<Failure, User>?> call(params) async {
    return repository.getUser();
  }
  
}
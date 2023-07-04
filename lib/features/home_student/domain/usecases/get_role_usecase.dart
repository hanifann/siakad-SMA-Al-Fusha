import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/home_student/domain/repositories/role_repository.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';

class GetRoleUseCase extends UseCase<User, NoParams> {
  final RoleRepository repository;

  GetRoleUseCase(this.repository);

  @override
  Future<Either<Failure, User>?> call(NoParams params) async {
    return repository.getRole();
  }
}
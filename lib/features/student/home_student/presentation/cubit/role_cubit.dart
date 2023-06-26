
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/domain/usecases/get_role_usecase.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit(this.useCase) : super(RoleInitial());

  final GetRoleUseCase useCase;

  void getRoleEvent() async {
    final role = await useCase(NoParams());
    role!.fold(
      (l) {

      }, 
      (r) => emit(RoleLoaded(_convertRole(r.data[0].role)))
    );
  }

  String _convertRole(String role) {
    if(role == '2'){
      return 'Pelajar';
    } else {
      return 'Pengajar';
    }
  }
}

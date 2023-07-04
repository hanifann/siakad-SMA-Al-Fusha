part of 'role_cubit.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

class RoleInitial extends RoleState {}

class RoleLoaded extends RoleState {
  final String role;

  const RoleLoaded(this.role);
}

part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthUnauthorized extends AuthState{
  
}

class AuthAuthenticated extends AuthState {
  final String id;

  const AuthAuthenticated(this.id);
}

class UserDataLoaded extends AuthState {}

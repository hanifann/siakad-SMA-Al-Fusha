part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent{
  final String username;
  final String password;

  const PostLoginEvent({required this.username, required this.password});
}

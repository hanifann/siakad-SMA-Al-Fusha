part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSucceed extends UserState {
  final User user;

  const UserSucceed(this.user);
}

class UserFailed extends UserState {
  final ErrorModel errorModel;

  const UserFailed(this.errorModel);

}

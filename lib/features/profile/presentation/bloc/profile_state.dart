part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded(this.user);
}

class ProfileFailed extends ProfileState {
  final ErrorModel error;

  const ProfileFailed(this.error);
}

class ProfileLoading extends ProfileState {
  
}

class LogoutSuccess extends ProfileState {
  
}

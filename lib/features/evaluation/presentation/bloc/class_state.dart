part of 'class_bloc.dart';

abstract class ClassState extends Equatable {
  const ClassState();
  
  @override
  List<Object> get props => [];
}

class ClassInitial extends ClassState {}

class ClassLoaded extends ClassState {
  final Class data;

  const ClassLoaded(this.data);
}

class ClassFailed extends ClassState {
  final ErrorModel error;

  const ClassFailed(this.error);
}

class ClassLoading extends ClassState {
  
}

class TokenLoaded extends ClassState {
  final User user;

  const TokenLoaded(this.user);
}

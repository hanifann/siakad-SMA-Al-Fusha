part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();
  
  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoaded extends StudentState {
  final Student student;

  const StudentLoaded(this.student);
}

class StudentFailed extends StudentState {
  final ErrorModel error;

  const StudentFailed(this.error);
}

class StudentLoading extends StudentState {
  
}

class TokenLoaded extends StudentState {
  final User user;

  const TokenLoaded(this.user);
}

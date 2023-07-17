part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetStudentByClassEvent extends StudentEvent {
  final String classId;

  const GetStudentByClassEvent(this.classId);
}

class GetTokenEvent extends StudentEvent {
  
}
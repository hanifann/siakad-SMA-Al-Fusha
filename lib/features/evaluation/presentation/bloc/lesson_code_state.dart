part of 'lesson_code_bloc.dart';

abstract class LessonCodeState extends Equatable {
  const LessonCodeState();
  
  @override
  List<Object> get props => [];
}

class LessonCodeInitial extends LessonCodeState {}

class LessonCodeLoaded extends LessonCodeState {
  final LessonCode lessonCode;

  const LessonCodeLoaded(this.lessonCode);
}

class LessonCodeFailed extends LessonCodeState {
  final ErrorModel error;

  const LessonCodeFailed(this.error);
}

class LessonCodeLoading extends LessonCodeState{
  
}
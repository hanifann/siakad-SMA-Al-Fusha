part of 'lesson_code_bloc.dart';

abstract class LessonCodeEvent extends Equatable {
  const LessonCodeEvent();

  @override
  List<Object> get props => [];
}

class GetLessonCodeEvent extends LessonCodeEvent {
  
}

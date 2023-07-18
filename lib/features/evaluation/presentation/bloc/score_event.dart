part of 'score_bloc.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class PostScoreEvent extends ScoreEvent {
  final String lessonCode;
  final String rph;
  final String pts;
  final String pat;

  const PostScoreEvent({
    required this.lessonCode, 
    required this.rph, 
    required this.pts, 
    required this.pat
  });
}
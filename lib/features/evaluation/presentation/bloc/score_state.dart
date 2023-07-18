part of 'score_bloc.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();
  
  @override
  List<Object> get props => [];
}

class ScoreInitial extends ScoreState {}

class ScoreSuccess extends ScoreState {
  
}

class ScoreFailed extends ScoreState {
  final ErrorModel error;

  const ScoreFailed(this.error);
}

class ScoreLoading extends ScoreState {
  
}

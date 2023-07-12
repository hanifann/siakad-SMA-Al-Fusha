part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();
  
  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;

  const ScheduleLoaded(this.schedule);
}

class ScheduleFailed extends ScheduleState {
  final ErrorModel error;

  const ScheduleFailed(this.error);
}

class ScheduleLoading extends ScheduleState {}

class  UserDataLoaded extends ScheduleState {
  final User user;

  const UserDataLoaded(this.user);
}

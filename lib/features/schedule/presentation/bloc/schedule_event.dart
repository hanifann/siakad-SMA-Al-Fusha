part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetScheduleEvent extends ScheduleEvent {
  final String id;
  final String day;

  const GetScheduleEvent({
    required this.id, 
    required this.day
  });
}
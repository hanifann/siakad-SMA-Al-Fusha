part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();
  
  @override
  List<Object> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {
  
}

class AnnouncementLoaded extends AnnouncementState {
  final Announcement announcement;

  const AnnouncementLoaded(this.announcement);
}

class AnnouncementFailed extends AnnouncementState {
  final ErrorModel errorModel;

  const AnnouncementFailed(this.errorModel);
}
part of 'nilai_bloc.dart';

abstract class NilaiEvent extends Equatable {
  const NilaiEvent();

  @override
  List<Object> get props => [];
}

class GetNilaiEvent extends NilaiEvent {
  final String id;

  const GetNilaiEvent(this.id);
}

class GetUserIdEvent extends NilaiEvent {
  
}

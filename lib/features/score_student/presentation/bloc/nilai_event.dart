part of 'nilai_bloc.dart';

abstract class NilaiEvent extends Equatable {
  const NilaiEvent();

  @override
  List<Object> get props => [];
}

class GetNilaiEvent extends NilaiEvent {
  final String id;
  final String tahunAJaranId;

  const GetNilaiEvent(this.id, this.tahunAJaranId);
}

class GetUserIdEvent extends NilaiEvent {
  
}

part of 'nilai_bloc.dart';

abstract class NilaiState extends Equatable {
  const NilaiState();
  
  @override
  List<Object> get props => [];
}

class NilaiInitial extends NilaiState {}

class NilaiLoading extends NilaiState {}

class NilaiLoaded extends NilaiState {
  final Nilai nilai;

  const NilaiLoaded(this.nilai);
}

class NilaiFailed extends NilaiState {
  final ErrorModel error;

  const NilaiFailed(this.error);
}

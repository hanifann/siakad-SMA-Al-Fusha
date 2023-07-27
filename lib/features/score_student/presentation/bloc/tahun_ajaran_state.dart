part of 'tahun_ajaran_bloc.dart';

abstract class TahunAjaranState extends Equatable {
  const TahunAjaranState();
  
  @override
  List<Object> get props => [];
}

class TahunAjaranInitial extends TahunAjaranState {}

class TahunAjaranLoaded extends TahunAjaranState {
  final TahunAjaran tahunAjaran;

  const TahunAjaranLoaded(this.tahunAjaran);
}

class TahunajaranFailed extends TahunAjaranState {
  final ErrorModel error;

  const TahunajaranFailed(this.error);
}

class TathunAjaranLoading extends TahunAjaranState {
  
}

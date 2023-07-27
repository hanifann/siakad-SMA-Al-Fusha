part of 'tahun_ajaran_bloc.dart';

abstract class TahunAjaranEvent extends Equatable {
  const TahunAjaranEvent();

  @override
  List<Object> get props => [];
}

class GetTahunAjaranEvent extends TahunAjaranEvent {
  
}

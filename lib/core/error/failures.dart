import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final int statusCode;

  const Failure({
    this.message = 'telah terjadi kesalahan, silahkan coba lagi', 
    required this.statusCode
  });

  @override
  List<Object> get props => [message!, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.statusCode,
    super.message
  });
}

class CacheFailure extends Failure {
  const CacheFailure({required super.statusCode, super.message});
  
}
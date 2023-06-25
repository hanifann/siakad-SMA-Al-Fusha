import 'package:siakad_sma_al_fusha/core/error/model/error.dart';

class ServerException implements Exception {
  final ErrorModel error;

  ServerException({required this.error});
}

class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'Telah terjadi kesalahan, silahkan cek koneksi internet anda'
  });
}
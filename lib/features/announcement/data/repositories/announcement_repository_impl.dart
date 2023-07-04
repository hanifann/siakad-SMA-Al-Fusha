import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_local_datasource.dart';
import 'package:siakad_sma_al_fusha/features/announcement/data/datasources/announcement_remote_datasource.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/repositories/announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final NetworkInfo networkInfo;
  final AnnouncementRemoteDataSource remoteDataSource;
  final AnnouncementLocalDataSource localDataSource;

  AnnouncementRepositoryImpl({
    required this.networkInfo, 
    required this.remoteDataSource, 
    required this.localDataSource
  });

  @override
  Future<Either<Failure, Announcement>>? getAnnouncement() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getAnnouncement();
        localDataSource.cachedAnnouncement(response!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      try {
        final jsonString = await localDataSource.getCachedAnnouncement();
        return Right(jsonString!);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
  
}
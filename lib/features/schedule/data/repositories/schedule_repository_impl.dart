import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/exception.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/platform/network_info.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final NetworkInfo networkInfo;
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl({
    required this.networkInfo, 
    required this.remoteDataSource
  });

  @override
  Future<Either<Failure, Schedule>>? getSchedule(String id, String day) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getSchedule(id, day);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.error.message));
      }
    } else {
      return const Left(ServerFailure());
    }
  }
  
}
import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/repositories/announcement_repository.dart';

class GetAnnouncementUseCase extends UseCase<Announcement, NoParams> {
  final AnnouncementRepository repository;

  GetAnnouncementUseCase({required this.repository});

  @override
  Future<Either<Failure, Announcement>?> call(NoParams params) async {
    return repository.getAnnouncement();
  }
  
}
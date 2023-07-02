import 'package:dartz/dartz.dart';
import 'package:siakad_sma_al_fusha/core/error/failures.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/domain/entities/announcement.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, Announcement>>? getAnnouncement();
}
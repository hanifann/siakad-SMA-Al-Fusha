import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/usecases/get_announcement_usecase.dart';

import 'get_announcement_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AnnouncementRepository>()])
void main() {
  late MockAnnouncementRepository mockRepository;
  late GetAnnouncementUseCase useCase;

  setUp(() {
    mockRepository = MockAnnouncementRepository();
    useCase = GetAnnouncementUseCase(repository: mockRepository);
  });

  final tAnnouncementDatum = AnnouncementDatum(
    id: '1', 
    tanggal: DateTime(2023), 
    judul: 'judul', 
    isiPengumuman: 'isiPengumuman'
  );

  final tAnnouncement = Announcement(data: [tAnnouncementDatum]);

  test('should get announcement data from repository', () async {
    //arrange
    when(mockRepository.getAnnouncement())
      .thenAnswer((_) async => Right(tAnnouncement));
    
    //act
    final response = await useCase(NoParams());

    //assert
    verify(mockRepository.getAnnouncement());
    expect(response, equals(Right(tAnnouncement)));
    verifyNoMoreInteractions(mockRepository);
  });
}
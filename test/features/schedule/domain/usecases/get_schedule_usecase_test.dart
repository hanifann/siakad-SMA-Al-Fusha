import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/usecases/get_schedule_usecase.dart';

import 'get_schedule_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ScheduleRepository>()])
void main() {
  late MockScheduleRepository mockScheduleRepository;
  late GetScheduleUseCase useCase;
  
  setUp((){
    mockScheduleRepository = MockScheduleRepository();
    useCase = GetScheduleUseCase(repository: mockScheduleRepository);
  });

  const tScheduleData = ScheduleData(
    guruPengampu: 'guruPengampu', 
    mapel: 'mapel', 
    kelas: 'kelas', 
    jam: 'jam', 
    jumlahJam: 'jumlahJam', 
    hari: 'hari'
  );

  const tSchedule = Schedule(data: [tScheduleData]);

  const tId = '1';
  const tDay = 'sunday';

  test('should get schedule from repository ', () async {
    //arrange
    when(mockScheduleRepository.getSchedule(tId, tDay))
      .thenAnswer((_) async => const Right(tSchedule));

    //act
    final response = await useCase(const ScheduleParam(id: tId, day: tDay));

    //assert
    verify(mockScheduleRepository.getSchedule(tId, tDay));
    expect(response, equals(const Right(tSchedule)));
    verifyNoMoreInteractions(mockScheduleRepository);
  });
}
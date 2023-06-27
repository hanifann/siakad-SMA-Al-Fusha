import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/repositories/nilai_repository.dart';
import 'package:siakad_sma_al_fusha/features/student/score_student/domain/usecases/get_nilai_usecase.dart';

import 'get_nilai_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NilaiRepository>()])
void main() {
  late MockNilaiRepository mockNilaiRepository;
  late GetNilasiUseCase useCase;

  setUp(() {
    mockNilaiRepository = MockNilaiRepository();
    useCase = GetNilasiUseCase(repository: mockNilaiRepository);
  });

  const tNilaiDatum = NilaiDatum(
    nama: 'nama', 
    rph: 'rph', 
    pts: 'pts', 
    pat: 'pat', 
    jumlah: 'jumlah', 
    rataRata: 'rataRata'
  );

  const tNilai = Nilai(data: [tNilaiDatum]);

  const tId = '1';

  test('should get nilai data from repository ', () async {
    //arrange
    when(mockNilaiRepository.getNilai(tId))
      .thenAnswer((_) async => const Right(tNilai));
    
    //act
    final response = await useCase(const NilaiParams(tId));

    //assert
    verify(mockNilaiRepository.getNilai(tId));
    expect(response, equals(const Right(tNilai)));
    verifyNoMoreInteractions(mockNilaiRepository);
  });
}
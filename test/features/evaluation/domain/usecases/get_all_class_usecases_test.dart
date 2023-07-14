import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_all_class_usecase.dart';

import 'get_all_class_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EvaluationRepository>()])
void main() {
  late MockEvaluationRepository mockRepository;
  late GetAllClassUseCase useCase;

  setUp(() {
    mockRepository = MockEvaluationRepository();
    useCase = GetAllClassUseCase(repository: mockRepository);
  });

  const tClassData = ClassData(id: '1', nama: 'nama');
  const tClass = Class(data: [tClassData]);

  test('should return class from repository', () async {
    //arrange
    when(mockRepository.getAllClass())
      .thenAnswer((_) async => const Right(tClass));

    //act
    final response = await useCase(NoParams());

    //assert
    verify(mockRepository.getAllClass());
    expect(response, equals(const Right(tClass)));
    verifyNoMoreInteractions(mockRepository);
  });
}
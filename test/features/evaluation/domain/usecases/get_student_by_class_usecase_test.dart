import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/student.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/usecases/get_student_by_class_usecase.dart';

import 'get_all_class_usecases_test.mocks.dart';

void main() {
  late MockEvaluationRepository repository;
  late GetStudentByClassUseCase useCase;

  setUp(() {
    repository = MockEvaluationRepository();
    useCase = GetStudentByClassUseCase(repository: repository);
  });

  const tStudentData = StudentDatum(namaUser: 'namaUser', namaKelas: 'namaKelas');
  const tStudent = Student(data: [tStudentData]);

  const tClassId = '1';

  test('should return list of student from repository', () async {
    //arrange
    when(repository.getStudentByClass(tClassId))
      .thenAnswer((_) async => const Right(tStudent));

    //act
    final response = await useCase(const StudentParam(tClassId));

    //assert
    verify(repository.getStudentByClass(tClassId));
    expect(response, equals(const Right(tStudent)));
    verifyNoMoreInteractions(repository);
  });
}
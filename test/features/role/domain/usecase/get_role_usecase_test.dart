import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/home_student/domain/repositories/role_repository.dart';
import 'package:siakad_sma_al_fusha/features/home_student/domain/usecases/get_role_usecase.dart';

import 'get_role_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RoleRepository>()])
void main() {
  late MockRoleRepository mockRoleRepository;
  late GetRoleUseCase  useCase;

  setUp(() {
    mockRoleRepository = MockRoleRepository();
    useCase = GetRoleUseCase(mockRoleRepository);
  });

  const tUserDatum = UserDatum(
    id: '1', 
    nama: 'nama', 
    username: 'username', 
    role: '2', 
    idUsers: '13', 
    tempat: 'tempat', 
    tglLahir: null, 
    pendidikan: null, 
    tmk: null, 
    jabatan: 'jabatan', 
    alamat: 'alamat', 
    tgsTam: 'tgsTam'
  );
  const tUser = User(data: [tUserDatum]);

  test('should get role from repository ', () async {
    //arrange
    when(mockRoleRepository.getRole())
      .thenAnswer((_) async => const Right(tUser));

    //act
    final response = await useCase(NoParams());

    //assert
    verify(mockRoleRepository.getRole());
    expect(response, equals(const Right(tUser)));
    verifyNoMoreInteractions(mockRoleRepository);
  });
}
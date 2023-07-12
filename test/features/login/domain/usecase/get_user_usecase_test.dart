import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/core/usecase/usecase.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/user.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/get_user_usecase.dart';

import 'post_login_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
void main() {
  late MockLoginRepository mockLoginRepository;
  late GetUserUseCase useCase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    useCase = GetUserUseCase(repository: mockLoginRepository);
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
    tgsTam: 'tgsTam',
    idKelas: 'idKelas'
  );
  const tUser = User(data: [tUserDatum]);

  test('should get user data from repository', () async {
    //arrange
    when(mockLoginRepository.getUser())
      .thenAnswer((_) async => const Right(tUser));

    //act
    final response = await useCase(NoParams());

    //assert
    verify(mockLoginRepository.getUser());
    expect(response, equals(const Right(tUser)));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/entities/login.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/repositories/login_repositoy.dart';
import 'package:siakad_sma_al_fusha/features/login/domain/usecase/post_login_usecase.dart';

import 'post_login_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
void main() {
  late MockLoginRepository mockLoginRepository;
  late PostLoginUseCase useCase;
  
  setUp((){
    mockLoginRepository = MockLoginRepository();
    useCase = PostLoginUseCase(repository: mockLoginRepository);
  });

  const tUsername = '54321';
  const tPassword = '54321';
  const tLogin = Login(data: 'token');

  test('should post login and return token from the repository', () async {
    //arrange
    when(mockLoginRepository.postLogin(any, any))
      .thenAnswer((_) async => const Right(tLogin));

    //act
    final result = await useCase(
      const LoginParams(username: tUsername, password: tPassword)
    );

    //assert
    expect(result, equals(const Right(tLogin)));
    verify(mockLoginRepository.postLogin(tUsername, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
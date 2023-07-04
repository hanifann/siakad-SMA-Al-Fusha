
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_sma_al_fusha/features/home/presentation/views/home_student_view.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/views/login_view.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..checkAuthenticationStatus(),
      child: const AuthPage(),
    );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if(state is AuthAuthenticated){
          return const HomeStudentView();
        } else if (state is AuthUnauthorized){
          return const LoginView();
        } else {
          return Scaffold(
            body: SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                )
              ),
            ),
          );
        }
      },
    );
  }
}
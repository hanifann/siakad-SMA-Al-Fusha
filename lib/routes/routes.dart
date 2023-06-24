import 'package:go_router/go_router.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/views/login_view.dart';
import 'package:siakad_sma_al_fusha/features/student/home_student/presentation/views/home_student_view.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/home_student',
      builder: (context, state) => const HomeStudentView(),
    )
  ],
);

import 'package:go_router/go_router.dart';
import 'package:siakad_sma_al_fusha/features/announcement/domain/entities/announcement.dart';
import 'package:siakad_sma_al_fusha/features/announcement_detail/views/announcement_detail_view.dart';
import 'package:siakad_sma_al_fusha/features/auth/presentation/views/auth_view.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/views/input_score_view.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/views/student_view.dart';
import 'package:siakad_sma_al_fusha/features/home/presentation/views/home_student_view.dart';
import 'package:siakad_sma_al_fusha/features/login/presentation/views/login_view.dart';
import 'package:siakad_sma_al_fusha/features/profile/presentation/views/profile_view.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/home_student',
      builder: (context, state) => const HomeStudentView(),
    ),
    GoRoute(
      path: '/pengumuman_detail',
      builder: (context, state) {
        AnnouncementDatum announcement = state.extra as AnnouncementDatum;
        return AnnouncementDetailView(announcement: announcement);
      }
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView()
    ),
    GoRoute(
      path: '/student',
      name: '/student',
      builder: (context, state) {
        return StudentView(
          kodeMapel: state.queryParameters['kodeMapel']!
        );
      }
    ),
    GoRoute(
      path: '/input_score',
      name: '/input_score',
      builder: (context, state) {
        return InputScoreView(
          idUser: state.queryParameters['idUser']!,
          namaSiswa: state.queryParameters['namaSiswa']!,
          kodeMapel: state.queryParameters['kodeMapel']!,
        );
      }
    ),
  ],
);

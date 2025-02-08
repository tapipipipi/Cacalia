import 'package:cacalia/features/ask/askform';
import 'package:cacalia/features/recruitment/recruitmentForm';
import 'package:cacalia/features/setting/pages/setting.dart';
import 'package:cacalia/features/timeline/pages/timeline.dart';
import 'package:go_router/go_router.dart';
import 'package:cacalia/features/exchange/pages/exchange.dart';
import 'package:cacalia/features/login/pages/login.dart';
import 'package:cacalia/features/home/pages/home.dart';
import 'package:cacalia/features/signUp/pages/signUpName.dart';
import 'package:cacalia/features/signUp/pages/signUpPass.dart';
import '../../store.dart';
import 'package:cacalia/features/profEdit/pages/profEdit.dart';
import 'package:cacalia/features/cardEdit/pages/cardEdit.dart';

final router = GoRouter(
  initialLocation: '/', // LoginPageを初期画面に設定
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(), 
    ),
    GoRoute(
      path: '/exchange',
      builder: (context, state) => const ExchangePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/signUpName',
      builder: (context, state) => const SignUpNamePage(),
    ),
    GoRoute(
      path: '/signUpPass',
      builder: (context, state) => const SignUpPassPage(),
    ),
    GoRoute(
      path: '/store',
      builder: (context, state) => const Store(),
    ),
    GoRoute(

      path: '/setting',
      builder: (context, state) => const Setting(),
    ),
    GoRoute(
      path: '/profEdit',
      builder: (context, state) => ProfEdit(),
    ),
    GoRoute(
      path: '/cardEdit',
      builder: (context, state) => const CardEdit(),
    ),
    GoRoute(
      path: '/timeLine',
      builder: (context, state) => const Timeline(),
    ),
    GoRoute(
      path: '/timeline',
      builder: (context, GoRouterState state) => const Timeline(),
    ),
    GoRoute(
      path: '/ask',
      builder: (context, GoRouterState state) => const Ask(),
    ),
    GoRoute(
      path: '/recruitment',
      builder: (context, GoRouterState state) => const Recruitment(),
    ),
  ],
);

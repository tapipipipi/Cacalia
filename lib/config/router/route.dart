import 'package:go_router/go_router.dart';
import 'package:cacalia/features/exchange/pages/exchange.dart';
import 'package:cacalia/features/login/pages/login.dart';
// import 'package:cacalia/features/home/pages/home.dart';
import 'package:cacalia/features/home/pages/home.dart';
import 'package:cacalia/features/signUp/pages/signUpName.dart';
import 'package:cacalia/features/signUp/pages/signUpPass.dart';
import '../../store.dart';

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

  ],
);

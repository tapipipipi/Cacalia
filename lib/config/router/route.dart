import 'package:go_router/go_router.dart';
import 'package:cacalia/features/exchange/pages/exchange.dart';
import 'package:cacalia/features/login/pages/login.dart';
import 'package:cacalia/features/home/pages/home.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),  // LoginPageを初期画面に設定
    ),
    GoRoute(
      path: '/exchange',
      builder: (context, state) => const ExchangePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
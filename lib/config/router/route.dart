import 'package:cacalia/features/setting/pages/setting.dart';
import 'package:cacalia/features/timeline/pages/timeline.dart';
import 'package:go_router/go_router.dart';
import 'package:cacalia/features/exchange/pages/exchange.dart';
import 'package:cacalia/features/login/pages/login.dart';
import 'package:cacalia/features/home/pages/home.dart';
import 'package:cacalia/features/signUp/pages/signUpName.dart';
import 'package:cacalia/features/signUp/pages/signUpPass.dart';
<<<<<<< HEAD
import '../../store.dart';
=======
import 'package:cacalia/features/profEdit/pages/profEdit.dart';
import 'package:cacalia/features/cardEdit/pages/cardEdit.dart';
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c

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
<<<<<<< HEAD
      path: '/store',
      builder: (context, state) => const Store(),
    ),

=======
      path: '/setting',
      builder: (context, state) => const Setting(),
    ),
    GoRoute(
      path: '/profEdit',
      builder: (context, state) => const ProfEdit(),
    ),
    GoRoute(
      path: '/cardEdit',
      builder: (context, state) => const CardEdit(),
    ),
    GoRoute(
      path: '/timeLine',
      builder: (context, state) => const Timeline(),
    ),
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c
  ],
);

import 'package:flutter/material.dart';
import 'package:cacalia/config/router/route.dart';
// routerをインポート
import 'package:cacalia/datas/designData.dart';
//APIキーを隠すライブラリ
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
//フォント変更を行うためのライブラリ
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // Firebase初期化処理　ここから
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // // Firebase初期化処理　ここまで
  // await FirebaseAuth.instance.signOut();

  await dotenv.load(fileName: ".env"); // .envをロード

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

//アプリ全体のフォントを変えるクラス
class ThemeNotifier extends ChangeNotifier {
  String _currentTheme = Fonts.font0;

// ゲッターで外部から読み取れるようにする
  String get currenttheme => _currentTheme;

// テーマを変更する関数
  void changeTheme(String newTheme) {
    _currentTheme = newTheme;
    //変更をリスナーに通知
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider から ThemeNotifier を取得
    final themeNotifier = context.watch<ThemeNotifier>();
    //現在のテーマ
    final currentTheme = themeNotifier.currenttheme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cacalia',
      theme: ThemeData(
        fontFamily: currentTheme,
        primarySwatch: Colors.blue,
      ),
      routerConfig: router, // route.dartで定義したrouterを使用
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cacalia/config/router/route.dart'; // routerをインポート
//APIキーを隠すライブラリ
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // Firebase初期化処理　ここから
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // // Firebase初期化処理　ここまで
  // await FirebaseAuth.instance.signOut();

  await dotenv.load(fileName: ".env"); // .envをロード

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cacalia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router, // route.dartで定義したrouterを使用
    );
  }
}

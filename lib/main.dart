import 'package:cacalia/features/home/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cacalia/config/router/route.dart';  // routerをインポート
import 'store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();   
  // // Firebase初期化処理　ここから
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );                                           
  // // Firebase初期化処理　ここまで
  // await FirebaseAuth.instance.signOut();
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

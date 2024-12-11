import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/config/router/route.dart'; // routerをインポート

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
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

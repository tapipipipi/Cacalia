import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../Auth/Authentication.dart';
import '../../../Auth/google_sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _mailaddressController = TextEditingController();
  final _passwordController = TextEditingController();

  // 入力したメールアドレス・パスワード
  String _email = '';
  String _pass = '';
  String defmail = '2230360@ecc.ac.com';
  String defpass = '123qwecc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7E6EF), // 背景色を#F5F5F5に設定
      body: ListView(
        padding: EdgeInsets.zero, // 追加: paddingをゼロに設定
        children: [
          Image.asset(
            'assets/images/CacaliaLoginHeader.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0, left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0), // 左右にスペースを追加
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30), // 端を真円に設定
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _mailaddressController,
                    decoration: const InputDecoration(
                      labelText: 'メールアドレス',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)), // 端を真円に設定
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスを入力してください';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9@_.-]+$').hasMatch(value)) {
                        // 入力文字の制限
                        return 'メールアドレスは英数字と一部の記号のみ使用できます';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0), // 左右にスペースを追加
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30), // 端を真円に設定
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'パスワード',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)), // 端を真円に設定
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                        // 入力文字の制限
                        return 'パスワードは英数字のみ使用できます';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _pass = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text('────────────または────────────'),
                const SizedBox(height: 24),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // データがまだ取得されていない場合のローディング表示
                    } else if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else {
                      // データが取得された場合
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 中央に配置
                        children: [
                          GoogleSignInButton(),
                          const SizedBox(height: 16), // Googleログインボタンの下にスペースを追加
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    print(_email);
                    print(_pass);
                    // -------------------------------------
                    // if (_formKey.currentState!.validate()) {
                    //   // TODO: ログイン処理を
                    // }
                    // ------------------------------------
                    // TODO: ログイン処理
                    try {
                      final nowuser = FirebaseAuth.instance.currentUser;
                      if (nowuser != null) {
                        print('User already signed in: ${nowuser.email}');
                        context.go('/home'); //これよくない
                      } else {
                        if (_email == "") {
                          _email = defmail;
                          _pass = defpass;
                        }
                        // Sign-in logic
                        // メール/パスワードでログイン
                        final User? user = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _pass))
                            .user;
                        // final String? uid = user?.uid;
                        if (user != null) {
                          print("ログインしました ${user.email} , ${user.uid}");
                          // ignore: use_build_context_synchronously
                          context.go('/home');
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // ボタンの色を青に設定
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 角丸に設定
                    ),
                  ),
                  child: const Text(
                    'ログイン',
                    style: TextStyle(
                      color: Colors.white, // 文字色を白に設定
                      fontSize: 18, // フォントサイズを大きく設定
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () {
                //     context.go('/home');
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.grey,
                //   ),
                //   child: const Text('デバッグ用：ホーム画面へ'),
                // ),
                const SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () async {
                //     // Googleログインの処理を追加
                //     // TODO: Googleログインの実装
                //   },
                //   child: const Text('Googleでログイン'),
                // ),
                TextButton(
                  onPressed: () {
                    context.go('/signUpName');
                  },
                  child: const Text('新規登録'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Future shinUp() async {
//   try {
//     final _auth = FirebaseAuth.instance();

//     // バリデーション後のメールアドレスとパスワードでアカウント登録
//     await _auth.createUserWithEmailAndPassword(email: _email, password: _pass);

//     // 確認メール送信
//     await _auth.currentUser.sendEmailVerification();
//   } catch (error) {
//     throw error;
//   }
// }

// Future login() async {
//   try {
//     final _auth = FirebaseAuth.instance();

//     // 一旦サインインします
//     await _auth.signInWithEmailAndPassword(
//       email: this.mail,
//       password: this.password,
//     );

//     // メール認証完了しているか取得
//     final _isVerified = await _auth.currentUser.emailVerified;

//     if (!_isVerified) {
//       // もう一度メール送信
//       _auth.currentUser.sendEmailVerification();

//       // サインアウトする
//       await _auth.signOut();
//       throw ('isNotVerified');
//     }
//   } catch (error) {
//     throw error;
//   }
// }

class SignUpNamePage extends StatefulWidget {
  const SignUpNamePage({super.key});

  @override
  State<SignUpNamePage> createState() => _SignUpNamePageState();
}

class _SignUpNamePageState extends State<SignUpNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _mailaddressController = TextEditingController();

  // 入力したメールアドレス・パスワード
  String _email = 'sample@ecc.com';
  String _pass = '123qwecc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7E6EF),
      body: ListView(
        padding: EdgeInsets.zero, // 追加: paddingをゼロに設定
        children: [
          Image.asset(
            'assets/images/CacaliaSignin.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0, left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 64), // 高さを調整して全体を下げる
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                        borderRadius: BorderRadius.all(Radius.circular(30)),
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
                    borderRadius: BorderRadius.all(Radius.circular(30)),
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
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      // labelText: 'ユーザー名',
                      labelText: 'パスワード',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ユーザー名を入力してください';
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
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    print(_email);
                    print(_pass);

                    // ---------------エラー(null許容)が起きるのでコメントアウトしてます---------
                    // if (_formKey.currentState!.validate()) {
                    //   // TODO: 認証用メールを飛ばして確認次第遷移する処理
                    // }
                    // ----------------------------------------------------------------------

                    try {
                      // TODO: 認証用メールを飛ばして確認次第遷移する処理

                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result =
                          await auth.createUserWithEmailAndPassword(
                        email: _email,
                        password: _pass,
                      );
                      print("seccess");
                      // // 登録したユーザー情報
                      // User? user = await result.user!;
                      // print("ユーザ登録しました ${user.email} , ${user.uid}");

                      // メール/パスワードでログイン
                      final User? loginuser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _pass))
                          .user;
                      // final String? uid = user?.uid;
                      if (loginuser != null) {
                        print("ログインしました ${loginuser.email} , ${loginuser.uid}");
                        //setUser();
                        // ignore: use_build_context_synchronously
                        context.go('/home');
                      }
                      // context.go('/');
                    } catch (e) {
                      print("失敗");
                      print(e);
                    }
                  },
                  child: const Text('次へ'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.go('/signUpPass');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('デバッグ用：次へ'),
                ),
                // const SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () async {
                //     // Googleログインの処理を追加
                //     // TODO: Googleログインの実装
                //   },
                //   child: const Text('Googleでサインイン'),
                // ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('ログインはこちら'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

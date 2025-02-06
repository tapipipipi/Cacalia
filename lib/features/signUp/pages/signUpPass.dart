import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPassPage extends StatefulWidget {
  const SignUpPassPage({super.key});

  @override
  State<SignUpPassPage> createState() => _SignUpPassPageState();
}

class _SignUpPassPageState extends State<SignUpPassPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwardAgainController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero, // 追加: paddingをゼロに設定
        children: [
          Image.asset(
            'assets/images/CreatePass.png',
            fit: BoxFit.cover,
          ),
            Padding(
            padding: const EdgeInsets.only(top: 0,left: 16.0,right: 16.0,bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) { // 入力文字の制限
                        return 'パスワードは英数字のみ使用できます';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                    controller: _passwardAgainController,
                    decoration: const InputDecoration(
                      labelText: 'パスワード：確認用',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'もう一度パスワードを入力してください';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) { // 入力文字の制限
                        return 'パスワードは英数字のみ使用できます';
                      }
                      if (value != _passwordController.text) { // パスワード一致チェック
                        return 'パスワードが一致していません';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: パスワードを登録してホームに遷移
                    
                    }
                  },
                  child: const Text('サインアップ'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('デバッグ用：サインアップ'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

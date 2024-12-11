import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // アカウント名表示領域
            Container(
              height: 100, // 高さは調整してください
              child: Center(
                child: Text(
                  'アカウント名',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            // 名前表示領域
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('苗字'),
                  Text('名前'),
                ],
              ),
            ),
            // 設定メニュー
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('名前の編集'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('プロフィールの編集'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('アプリの設定'),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
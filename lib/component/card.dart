import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {

  // 変数を宣言
  final int userId;

  // テストデータ(ユーザー)
  static const userList = [
    [0, '文元 沙弥', 'Humimoto Saya'],
    [1, '谷岡 義貴', 'Tanioka Yoshitaka'],
    [2, '深尾 悠', 'Hukao Yu'],
    [3, '財前 颯', 'Zaizen Hayate'],
    [4, '馬場 周友', 'Banba Syuyu'],
  ];

  // super.keyと引数の指定
  const UserCard({
    super.key,
    required this.userId   // required 修飾子を付ける(非null制約を解除)
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,                // 影の離れ具合
      shadowColor: Colors.black, // 影の色
      child: Container(
        height: 159,
        width: 270,
        color: Colors.blueGrey,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            // 読み仮名
            Text(
              userList[userId][1] as String, // '文元沙弥' のような名前を取得
              style: const TextStyle(fontSize: 14),
            ),
            // 名前
            Text(
              userList[userId][2] as String,
              style: const TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
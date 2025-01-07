import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  // 変数を宣言
  final int userId; // ユーザーID
  final bool state; // Gitの更新、募集予定のマークの表示設定

  // テストデータ(ユーザー)
  static const userList = [
    [0, '文元 沙弥', 'Humimoto Saya'],
    [1, '谷岡 義貴', 'Tanioka Yoshitaka'],
    [2, '深尾 悠', 'Hukao Yu'],
    [3, '財前 颯', 'Zaizen Hayate'],
    [4, '馬場 周友', 'Banba Syuyu'],
  ];

  final String bgImg = 'assets/images/noImage.png';

  // super.keyと引数の指定
  const UserCard({
    super.key,
    required this.userId,
    required this.state, // required 修飾子を付ける(非null制約を解除)
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          elevation: 5, // 影の離れ具合
          shadowColor: Colors.black, // 影の色
          child: Container(
            height: 159,
            width: 270,
            alignment: const Alignment(-0.8, 0),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/noImage.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
              children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                // 読み仮名
                Text(
                  userList[userId][2] as String, // '文元沙弥' のような名前を取得
                  style: const TextStyle(fontSize: 14),
                ),
                // 名前
                Text(
                  userList[userId][1] as String,
                  style: const TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ),
        (state
            ?
            // 影の部分
            Container(
                height: 159,
                width: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.grey.shade400],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    //Todo:tureなら黄色、falseなら白にする処理
                    Icon(
                      Icons.lightbulb_rounded,
                      color: Color.fromRGBO(247, 204, 65, 1),
                      // color: Colors.white,
                    ),
                    SizedBox(height: 10), // margin代わり
                    Icon(
                      Icons.event,
                      // color: Color.fromRGBO(247, 204, 65, 1),
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            : Container())
      ],
    );
  }
}

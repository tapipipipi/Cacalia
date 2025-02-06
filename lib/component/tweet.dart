import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import '../CS/create.dart';

class Tweet extends StatelessWidget {
  // 変数を宣言
  final int userId; // ユーザーID
  final bool tweet; // Gitの更新、募集予定のマークの表示設定

  // テストデータ(ユーザー)
  static const userList = [
    [0, '文元 沙弥', 'Humimoto Saya'],
    [1, '谷岡 義貴', 'Tanioka Yoshitaka'],
    [2, '深尾 悠', 'Hukao Yu'],
    [3, '財前 颯', 'Zaizen Hayate'],
    [4, '馬場 周友', 'Banba Syuyu'],
  ];

  // super.keyと引数の指定
  const Tweet({
    super.key,
    required this.userId,
    required this.tweet, // required 修飾子を付ける(非null制約を解除)
  });

  @override
  Widget build(BuildContext context) {
    //cardListでフレンドの名前と読み仮名を取得している
    // print(cardList);

    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          elevation: 5, // 影の離れ具合
          shadowColor: Colors.black, // 影の色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 159,
            width: 270,
            alignment: const Alignment(-0.8, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // ✅ 画像や背景を丸くする
              border: Border.all( // ✅ 枠線を追加
                color: Colors.grey, // 枠線の色
                width: 2, // 枠線の太さ
              ),
            ),            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
              children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                Padding(
                  padding: const EdgeInsets.only(left: 16), // アイコンと名前の左側にマージンを追加
                  child: Row(
                    children: [
                      Icon(Icons.person), // アイコンを追加
                      const SizedBox(width: 8), // アイコンとテキストの間にスペースを追加
                      Text(
                        cardList[userId][1] as String, // 名前や読み仮名
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16), // 内容の左側にマージンを追加
                  child: Text(
                    cardList[userId][0] as String, // 内容
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
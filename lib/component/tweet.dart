// import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import '../features/timeline/pages/timeline.dart';

class Tweet extends StatelessWidget {
  // 変数を宣言
  final int userId; // ユーザーID
  final bool tweet; // Gitの更新、募集予定のマークの表示設定

  // テストデータ(ユーザー)
  static const userList = [
    ['', 'ここにはユーザーの投稿が表示されます', ''],
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
    print("tweet.dart");
    var def;
  
    // if (friends.isEmpty) {
    //   def = userList;
    // } else {
    //   def = tweets;
    // }

    

    def = tweets;


    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8), // ✅ `Card` の下に 20px の余白を追加
          child: Card(
            elevation: 5, // 影の離れ具合
            shadowColor: Colors.black, // 影の色
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 159,
              width: 315,
              alignment: const Alignment(-0.8, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // ✅ 画像や背景を丸くする
                border: Border.all(
                  // ✅ 枠線を追加
                  color: Colors.grey, // 枠線の色
                  width: 2, // 枠線の太さ
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
                children: [
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16), // アイコンと名前の左側にマージンを追加
                    child: Row(
                      children: [
                        Icon(Icons.person), // アイコンを追加
                        const SizedBox(width: 8), // アイコンとテキストの間にスペースを追加
                        Text(
                          def[userId][0] as String,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16), // 内容の左側にマージンを追加
                    child: Text(
                      def[userId][1] as String,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

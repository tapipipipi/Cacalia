import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import '../CS/create.dart';

class UserCard extends StatelessWidget {
  // 変数を宣言
  final int userId; // test

  // super.keyと引数の指定
  UserCard({super.key, required this.userId
      //required dynamic friendsCardList // required 修飾子を付ける(非null制約を解除)
      });

  final String bgImg = 'assets/images/default_avatar.png';

  @override
  Widget build(BuildContext context) {
    //cardListでフレンドの名前と読み仮名を取得している
    // print(cardList);

    return Stack(
      alignment: Alignment.centerRight,
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
              image: AssetImage('assets/images/card_def.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
              children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                // 読み仮名
                Text(
                  cardList[userId][1] as String, 
                  style: const TextStyle(fontSize: 14),
                ),
                // 名前
                Text(
                  cardList[userId][0] as String,
                  style: const TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ),
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
      ],
    );
  }
}

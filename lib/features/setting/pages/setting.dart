// アプリ設定画面
import 'package:cacalia/features/home/pages/home.dart';
import 'package:cacalia/store.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/footer.dart';
import 'package:cacalia/component/card.dart';
import 'package:go_router/go_router.dart';
import '../../../Auth/Authentication.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(215, 230, 239, 1),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(20),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          //白コンテナのサイズ
          width: 360,
          height: 800,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 30), // 余白を調整
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, left: 20.0), //下のメニューの両サイドの空白
                  child: Row(children: [
                    //アイコン
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/640px-PNG_transparency_demonstration_1.png',
                      width: 100, // 幅を200ピクセルに設定
                      height: 100, // 高さを200ピクセルに設定
                    ),
                    const Text(
                      'アカウント名',
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                ),
                // 名刺----------------------------------------
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 70),
                  child:  UserCard(userId: mycard), // ユーザーの番号
                ),
                // 編集の項目
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // サイズを必要最小限に
                    children: [
                      InkWell(
                        // ----------------名刺編集-------------------------
                        onTap: () {
                          context.go('/cardEdit');
                        },
                        // -----------------------------------------------
                        child: const CustomListTile(
                          icon: Icons.badge_outlined,
                          text: '名刺の編集',
                        ),
                      ),
                      InkWell(
                        // ---------------プロフィール編集------------------
                        onTap: () {
                          context.go('/profEdit');
                        },
                        // ------------------------------------------------
                        child: const CustomListTile(
                          icon: Icons.person,
                          text: 'プロフィールの編集',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/profEdit');
                        },
                        child: const CustomListTile(
                          icon: Icons.settings,
                          text: 'アプリの設定',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomListTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 35.0, left: 35.0), //下のメニューの両サイドの空白

      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.0), // ボーダー
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: Color(0xFF115A84)),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

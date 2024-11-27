import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(215, 230, 239, 1),
        body: Center(
          child:Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //白コンテナのサイズ
            width: 400,
            height: 800,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 30, 16, 30), // 余白を調整
              child: Column(
                children: [
                  Container(
                    margin:const EdgeInsets.only(top:20,left:20.0),//下のメニューの両サイドの空白
                    child:Row(
                      children:[
                        //アイコン
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/640px-PNG_transparency_demonstration_1.png',
                            width: 100, // 幅を200ピクセルに設定
                            height: 100, // 高さを200ピクセルに設定
                          ),              
                        Text(
                          'アカウント名',
                          style: TextStyle(fontSize: 18),
                        ),
                      ]
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100, right: 20, bottom: 30, left: 40),                    width: 80,
                    height: 80,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100), // 名刺のコンテナの位置高さ調整
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // サイズを必要最小限に
                      children: [
                        CustomListTile(
                          icon: Icons.badge_outlined,
                          text: '名前の編集',
                        ),
                        CustomListTile(
                          icon: Icons.person,
                          text: 'プロフィールの編集',
                        ),
                        CustomListTile(
                          icon: Icons.settings,
                          text: 'アプリの設定',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  CustomListTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(right: 35.0,left:35.0),//下のメニューの両サイドの空白

      decoration: BoxDecoration(
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
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

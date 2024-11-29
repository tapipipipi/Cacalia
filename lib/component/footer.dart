import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // グラデーション背景
        Container(
          height: 80, // BottomNavigationBarの高さに合わせる
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(17, 90, 132, 1),
                Color.fromRGBO(40, 158, 225, 1)
              ], // グラデーション色
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // BottomNavigationBarを重ねる
        BottomNavigationBar(
          backgroundColor: Colors.transparent, // 背景色を透明にする
          elevation: 0, // 影を消す
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ballot_rounded),
              label: '掲示板',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'アカウント',
            ),
          ],
          selectedItemColor: Colors.white, // 選択中のアイコンの色
          unselectedItemColor: Colors.white, // 非選択アイコンの色
          iconSize: 35,
        ),
      ],
    );
  }
}

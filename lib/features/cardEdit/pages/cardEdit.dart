// 名刺編集画面
import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/editButtons.dart';
import 'package:cacalia/component/card.dart';

class CardEdit extends StatelessWidget {
  const CardEdit({super.key});

  /*
    名詞の編集を保存する処理
  */
  Future<void> saveCards() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          UserCard(userId: mycard, state: false),
          EditButtons(editType: false, onSave: saveCards),
          Container(
            margin: EdgeInsets.only(top: 120, left: 220),
            child: IconButton(
              onPressed: () => (print('フォルダ開いて画像選択させてくれい')),
              icon: const Icon(Icons.camera_alt),
              color: const Color.fromRGBO(153, 153, 153, 1),
            ),
          ),
        ],
      ),
    );
  }
}

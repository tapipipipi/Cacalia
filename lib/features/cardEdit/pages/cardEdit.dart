// 名刺編集画面
import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/editButtons.dart';
import 'package:cacalia/component/card.dart';

class CardEdit extends StatelessWidget {
  const CardEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          UserCard(userId: mycard),
          //-------------------------todo--------------------------
         // 保存メソッドを作成し、第二引数にいれよ
          // EditButtons(editType: false, onSave: ),
        ],
      ),
    );
  }
}

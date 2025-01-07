// 名刺編集画面
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
          const UserCard(userId: 1, state: false),
          EditButtons(editType: false),
        ],
      ),
    );
  }
}

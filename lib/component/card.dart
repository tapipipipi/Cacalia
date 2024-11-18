import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {

  final String userName;
  // final String userRubi;

  UserCard({required this.userName});   // required 修飾子を付ける(非null制約を解除)

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,                // 影の離れ具合
      shadowColor: Colors.black, // 影の色
      child: Container(
        height: 159,
        width: 270,
        color: Colors.blueGrey,
        child: Column(
          children: [
            Text(userName)
          ],
        ),
      ),
    );
  }
}
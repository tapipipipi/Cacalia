//テーマ編集
import 'package:flutter/material.dart';

void EditModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9, // 高さを動的に設定
        width: double.infinity,
        child: Column(
          children: [
            // 閉じるためのバー
            Container(
              height: 11,
              width: 93,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Column(
              children: [
                Text('背景テーマの選択'),
                Container(
                  child: Row(
                    children: [
                      // ElevatedButton(onPressed: onPressed, child: child)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

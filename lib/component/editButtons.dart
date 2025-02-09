//編集画面で使うボタン
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cacalia/component/editModal.dart';

class EditButtons extends StatelessWidget {
  //プロフィールと名刺の編集を入れ替えるボタン部分に使う変数
  //true：名刺編集へ　false：プロフィール編集へ
  bool editType;
  final VoidCallback onSave; // 変更を保存する

  EditButtons({super.key, required this.editType, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/setting');
                },
                icon: const Icon(Icons.keyboard_arrow_left),
                iconSize: 40,
                color: Colors.black,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10)),
                  onPressed: () {
                    editType
                        ? context.go('/cardEdit')
                        : context.go('/profEdit');
                  },
                  child: editType
                      ? const Icon(
                          Icons.chrome_reader_mode_rounded,
                          size: 30,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.chrome_reader_mode_outlined,
                          size: 30,
                          color: Colors.black,
                        )),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () async {
                // 保存する処理を実行
                onSave();

                context.go('/setting');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10) //こちらを適用
                    ),
                backgroundColor: Colors.black,
              ),
              child: const Text(
                '保存',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditPen extends Container {
  String bgStyle = '';
  String fontStyle = '';

  // コンストラクタで引数を受け取る
  EditPen({required this.bgStyle, required this.fontStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {
        EditModal(context),
        showAboutDialog(context: context),
        Navigator.pop(context, {bgStyle, fontStyle}),
        print('--------------------[EditPen保存]--------------------'),
        print('\\\\\\\\\\\\\\'),
        print('\\\\\\\\\\\\\\'),
        print('\\\\\\\\\\\\\\'),
        print(bgStyle),
        print(fontStyle),
        print('\\\\\\\\\\\\\\'),
        print('\\\\\\\\\\\\\\'),
        print('\\\\\\\\\\\\\\'),
      },
      icon: Icon(
        Icons.edit_square,
        color: Colors.grey[800],
      ),
    );
  }
}

// void showThemeEditor(BuildContext context) async {
//   // モーダルを呼び出して、結果を受け取る
//   final result = await EditModal(context);
//   var selectBg = 0;
//   var selectFont = 0;

//   if (result != null) {
//     // タプルを分解して各値を取得
//     final targetBg = selectBg;
//     final targetFont = selectFont;
//     print('Selected Background: $targetFont');
//     print('Selected Font: $targetFont');
//     // 必要に応じて状態を更新するなどの処理を行う
//   } else {
//     print('No selection made.');
//   }
// }

// プロフィール編集画面
// ignore_for_file: unnecessary_string_interpolations

import 'dart:collection';

// import 'package:cacalia/component/editModal.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/editButtons.dart';
import 'package:cacalia/datas/designData.dart';

var targetBg = 0;
var targetFont = 0;

class ProfEdit extends StatelessWidget {
  ProfEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(switch (targetBg) {
            0 => bgImg.design0,
            1 => bgImg.design1,
            2 => bgImg.design2,
            3 => bgImg.design3,
            int() => throw UnimplementedError(),
          }),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          // 編集の共有のボタンのコンポネントを重ねるためにStack
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'about me',
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: switch (targetFont) {
                              0 => Fonts.font0,
                              1 => Fonts.font1,
                              2 => Fonts.font2,
                              3 => Fonts.font3,
                              4 => Fonts.font4,
                              // TODO: Handle this case.
                              int() => throw UnimplementedError(),
                            }),
                      ),
                    ),
                    IconButton(
                      onPressed: () => showThemeEditor(context),
                      icon: Icon(
                        Icons.edit_square,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 350,
                          height: 700,
                          margin: const EdgeInsets.only(top: 70),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '苗字　名前',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  EditPen(),
                                ],
                              ),
                              const Text(
                                'myoji namae',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10), // 余白
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (int i = 10; i >= 0; i--)
                                      Category('カテゴリー'),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                        // ユーザーアイコン
                        Positioned(
                          left: 125,
                          top: 10,
                          child: GestureDetector(
                            onTap: () {
                              print('フォルダ開いて画像選択させてくれい');
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 103,
                                  height: 103,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 8,
                                    ),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/default_avatar.png')),
                                  ),
                                ),
                                Container(
                                  width: 103,
                                  height: 103,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black45,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            EditButtons(editType: true),
          ],
        ),
      ),
    );
  }
}

//カテゴリーのバー
// ignore: must_be_immutable
class Category extends Container {
  String categoryName;

  Category(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 28,
          width: 240,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(109, 91, 93, 1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 6),
                blurRadius: 4.0, //ぼかし
              ),
            ],
          ),
          child: Text(
            categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(bottom: 15),
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              hintText: '最初に表示されてる文字だよ',
            ),
            // contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
          ),
        ),
      ],
    );
  }
}

class ThemeEditor extends StatefulWidget {
  const ThemeEditor({super.key});

  @override
  _ThemeEditorState createState() => _ThemeEditorState();
}

class _ThemeEditorState extends State<ThemeEditor> {
  List<bool> _bgtheme = [true, false, false, false];
  List<bool> _fonttheme = [true, false, false, false, false];
  int selectBg = 0;
  int selectFont = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // モーダルを閉じる際に値を返す
        Navigator.of(context).pop((selectBg, selectFont));
        return false;
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: Column(
          children: [
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('背景テーマの選択', style: TextStyle(fontSize: 16)),
                ToggleButtons(
                  splashColor: Colors.blue[500],
                  fillColor: Colors.blue[100],
                  onPressed: (int selectedIndex) {
                    setState(() {
                      _bgtheme = List.generate(
                        _bgtheme.length,
                        (index) => index == selectedIndex,
                      );
                      selectBg = selectedIndex; // 背景テーマの選択
                    });
                  },
                  isSelected: _bgtheme,
                  children: List.generate(4, (index) => Text('Bg $index')),
                ),
                const SizedBox(height: 30),
                const Text('文字テーマの選択', style: TextStyle(fontSize: 16)),
                ToggleButtons(
                  splashColor: Colors.blue[500],
                  fillColor: Colors.blue[100],
                  onPressed: (int selectedIndex) {
                    setState(() {
                      _fonttheme = List.generate(
                        _fonttheme.length,
                        (index) => index == selectedIndex,
                      );
                      selectFont = selectedIndex; // 文字テーマの選択
                    });
                  },
                  isSelected: _fonttheme,
                  children: List.generate(5, (index) => Text('Font $index')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

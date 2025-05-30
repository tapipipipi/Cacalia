// テーマ編集
import 'package:cacalia/CS/create.dart';
import 'package:cacalia/features/home/pages/home.dart';
import 'package:cacalia/main.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/datas/designData.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cacalia/features/profEdit/pages/profEdit.dart';

// モーダルの大枠
// ignore: non_constant_identifier_names
// Future<(int, int)> EditModal(BuildContext context) async {
//   final result = await showModalBottomSheet<(int, int)?>(
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return const ThemeEditor();
//     },
//   );

//   // nullの場合にデフォルト値を返す
//   return result ?? (0, 0); // 必要に応じて適切なデフォルト値を指定
// }

int selectBg = 0;
int selectFont = 0;

// ignore: non_constant_identifier_names
void EditModal(BuildContext context) async {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const ThemeEditor();
      });
}

// モーダルの中身
class ThemeEditor extends StatefulWidget {
  const ThemeEditor({super.key});
  @override
  _ThemeEditorState createState() => _ThemeEditorState();
}

class _ThemeEditorState extends State<ThemeEditor> {
  List<bool> _bgtheme = [true, false, false, false];
  List<bool> _fonttheme = [true, false, false, false, false];
  ProfEdit themechange = ProfEdit();

  @override
  Widget build(BuildContext context) {
    //フォントを変えるため宣言
    final themeNotifier = context.read<ThemeNotifier>();

    // ignore: deprecated_member_use
    return SizedBox(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '背景テーマの選択',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: ToggleButtons(
                  splashColor: Colors.blue[500],
                  fillColor: Colors.blue[100],
                  onPressed: (int selectedIndex) {
                    final list = List.generate(
                            _bgtheme.length, (index) => index == selectedIndex)
                        .toList();
                    setState(() {
                      _bgtheme = list;
                      selectBg = selectedIndex;
                    });
                  },
                  isSelected: _bgtheme,
                  children: <Widget>[
                    Image.asset('assets/images/designCircles/circle0.png'),
                    Image.asset('assets/images/designCircles/circle1.png'),
                    Image.asset('assets/images/designCircles/circle2.png'),
                    Image.asset('assets/images/designCircles/circle3.png'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '文字テーマの選択',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: ToggleButtons(
                  splashColor: Colors.blue[500],
                  fillColor: Colors.blue[100],
                  onPressed: (int selectedIndex) {
                    final list = List.generate(_fonttheme.length,
                        (index) => index == selectedIndex).toList();
                    setState(() {
                      _fonttheme = list;
                      selectFont = selectedIndex;
                    });
                  },
                  isSelected: _fonttheme,
                  children: const <Widget>[
                    Text(
                      'Aa',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      'Aa',
                      style: TextStyle(
                          fontSize: 40, fontFamily: 'ArchitectsDaughter'),
                    ),
                    Text(
                      'Aa',
                      style: TextStyle(fontSize: 40, fontFamily: 'Anton'),
                    ),
                    Text(
                      'Aa',
                      style: TextStyle(fontSize: 40, fontFamily: 'Lobster'),
                    ),
                    Text(
                      'Aa',
                      style: TextStyle(fontSize: 40, fontFamily: 'PirataOne'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              themechange.updatetheme(selectBg.toString(),
                  selectFont.toString(), selectBg.toString());
              // Navigator.of(context).pop({selectBg, selectFont});
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Profedit()), // 現在のページを再ロード
              );
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
        ],
      ),
    );
    // WillPopScope(
    //   onWillPop: () {
    //     Navigator.of(context).pop((selectBg, selectFont));
    //     return Future.value(false);
    //   },
    //   child: Container(
    //     height: MediaQuery.of(context).size.height * 0.9, // 高さを動的に設定
    //     width: double.infinity,
    //     child: Column(
    //       children: [
    //         // 閉じるためのバー
    //         Container(
    //           height: 11,
    //           width: 93,
    //           margin: const EdgeInsets.only(top: 20, bottom: 20),
    //           decoration: BoxDecoration(
    //             color: Colors.grey.shade300,
    //             borderRadius: BorderRadius.circular(20.0),
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const Text(
    //               '背景テーマの選択',
    //               style: TextStyle(fontSize: 16),
    //             ),
    //             Container(
    //               margin: const EdgeInsets.only(top: 10),
    //               child: ToggleButtons(
    //                 splashColor: Colors.blue[500],
    //                 fillColor: Colors.blue[100],
    //                 onPressed: (int selectedIndex) {
    //                   final list = List.generate(_bgtheme.length,
    //                       (index) => index == selectedIndex).toList();
    //                   setState(() {
    //                     _bgtheme = list;
    //                     selectBg = selectedIndex;
    //                   });
    //                 },
    //                 isSelected: _bgtheme,
    //                 children: <Widget>[
    //                   Image.asset('assets/images/designCircles/circle01.png'),
    //                   Image.asset('assets/images/designCircles/circle02.png'),
    //                   Image.asset('assets/images/designCircles/circle03.png'),
    //                   Image.asset('assets/images/designCircles/circle04.png'),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 30),
    //             const Text(
    //               '文字テーマの選択',
    //               style: TextStyle(fontSize: 16),
    //             ),
    //             Container(
    //               margin: const EdgeInsets.only(top: 10),
    //               child: ToggleButtons(
    //                 splashColor: Colors.blue[500],
    //                 fillColor: Colors.blue[100],
    //                 onPressed: (int selectedIndex) {
    //                   final list = List.generate(_fonttheme.length,
    //                       (index) => index == selectedIndex).toList();
    //                   setState(() {
    //                     _fonttheme = list;
    //                     selectFont = selectedIndex;
    //                   });
    //                 },
    //                 isSelected: _fonttheme,
    //                 children: const <Widget>[
    //                   Text(
    //                     'Aa',
    //                     style: TextStyle(fontSize: 40),
    //                   ),
    //                   Text(
    //                     'Aa',
    //                     style: TextStyle(
    //                         fontSize: 40, fontFamily: 'ArchitectsDaughter'),
    //                   ),
    //                   Text(
    //                     'Aa',
    //                     style: TextStyle(fontSize: 40, fontFamily: 'Anton'),
    //                   ),
    //                   Text(
    //                     'Aa',
    //                     style: TextStyle(fontSize: 40, fontFamily: 'Lobster'),
    //                   ),
    //                   Text(
    //                     'Aa',
    //                     style: TextStyle(fontSize: 40, fontFamily: 'PirataOne'),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

void getter(bgStyle, fontStyle) {
  bgStyle = selectBg;
  fontStyle = selectBg;
}

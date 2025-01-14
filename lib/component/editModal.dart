// テーマ編集
import 'package:flutter/material.dart';

// モーダルの大枠
// ignore: non_constant_identifier_names
Future<(int, int)?> EditModal(BuildContext context) async {
  return await showModalBottomSheet<(int, int)>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ThemeEditor();
    },
  );
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
  int selectBg = 0;
  int selectFont = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop((selectBg, selectFont));
        return Future.value(false);
      },
      child: Container(
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
                      final list = List.generate(_bgtheme.length,
                          (index) => index == selectedIndex).toList();
                      setState(() {
                        _bgtheme = list;
                        selectBg = selectedIndex;
                      });
                    },
                    isSelected: _bgtheme,
                    children: <Widget>[
                      Image.asset('assets/images/designCircles/circle01.png'),
                      Image.asset('assets/images/designCircles/circle02.png'),
                      Image.asset('assets/images/designCircles/circle03.png'),
                      Image.asset('assets/images/designCircles/circle04.png'),
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
          ],
        ),
      ),
    );
  }
}

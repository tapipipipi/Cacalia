// プロフィール編集画面
import 'package:cacalia/CS/create.dart';
import 'package:cacalia/component/editModal.dart';
// ignore_for_file: unnecessary_string_interpolations

// import 'package:cacalia/component/editModal.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/editButtons.dart';
import '../../home/pages/home.dart';
import 'package:cacalia/datas/designData.dart';

// 自身のプロフィールを取得し表示させる
List<String> keys = ["コメント", "イベント", "所属", "得意", "興味のあること", "趣味", "経歴"];
List<String> feildnames = [
  "comment",
  "events",
  "belong",
  "skill",
  "interest",
  "hoby",
  "background"
];

class Profedit extends StatefulWidget {
  const Profedit({super.key});

  @override
  State<Profedit> createState() => ProfEdit();
}

class ProfEdit extends State<Profedit> {
  late Future<void>? _profileFuture; //Futureの変数を作成
  var targetBg = '0';
  var targetFont = '0';

  // 自身の名前、読み仮名、デザインテーマ
  String name = profileList[myuid]["name"];
  String readname = profileList[myuid]["read_name"];
  String design = profileList[myuid]["wigetteme"];
  String font = profileList[myuid]["chartheme"];

  // 各フィールド用のコントローラーリストを作成
  final List<TextEditingController> controllers =
      List.generate(feildnames.length, (index) => TextEditingController());

  List<String> values = [];

  @override
  void initState() {
    super.initState();
    _refreshProfile(); // 初回読み込み
  }

  // Futureを更新してUIをリフレッシュ
  void _refreshProfile() {
    setState(() {
      _profileFuture = null; // Futureを更新
    });

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _profileFuture = setprofileList(); // 新しい Future を再設定
      });
    });
  }

  //テーマを適応して画面更新
  Future<void> updatetheme(
      String wigetteme, String chartheme, String cardtheme) async {
    await updateProfile('wigetteme', setBg(wigetteme.toString()));
    await updateProfile('chartheme', setFont(chartheme.toString()));
    await updateProfile('cardtheme', setCardTheme(cardtheme.toString()));

    _refreshProfile();
  }

  Future<void> setprofileList() async {
    // 自身の該当するプロフィールを取得しvaluesに格納
    for (int i = 0; i < feildnames.length; i++) {
      int currentValue = i;
      String field = await getProfileField(myuid, feildnames[currentValue]);
      values.add(field);
    }

    for (int i = 0; i < controllers.length; i++) {
      controllers[i].text = values[i];
    }
    for (var controller in controllers) {
      print('Controller text: ${controller.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // EditButtonsで使用するコントローラーから値を取得する関数
    Future<void> saveValues() async {
      List<String> updatedValues =
          controllers.map((controller) => controller.text).toList();
      print("Updated Values: $updatedValues");
      // ここでupdatedValuesを保存する処理を追加
      for (int i = 0; i < feildnames.length; i++) {
        updateProfile(feildnames[i], updatedValues[i]);
      }
    }

// 自身のプロフィールを取得するため、描画する前に通信する処理
    return Scaffold(
      body: FutureBuilder<void>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (_profileFuture == null) {
            return Center(child: CircularProgressIndicator()); // 再読み込み中のインジケーター
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          } else {
            // 非同期処理が完了したら描画
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(design),
                  fit: BoxFit.cover,
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.black, fontFamily: font),
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
                                  style:
                                      TextStyle(fontSize: 40, fontFamily: font),
                                ),
                              ),
                              EditPen(bgStyle: targetBg, fontStyle: targetFont),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              name,
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            EditPen(
                                                bgStyle: targetBg,
                                                fontStyle: targetFont),
                                          ],
                                        ),
                                        Text(
                                          readname,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10), // 余白
                                        Expanded(
                                            child: SingleChildScrollView(
                                          child: Column(
                                            //----------------------------------------
                                            children: [
                                              for (int i = 0;
                                                  i < feildnames.length;
                                                  i++)
                                                Category(keys[i], values[i],
                                                    controllers[i]),
                                            ],
                                            //----------------------------------------
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
                      //****************************************************************** */
                      EditButtons(editType: true, onSave: saveValues),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

//カテゴリーのバー
// ignore: must_be_immutable
class Category extends Container {
  String categoryName; // key
  String value; // value
  final TextEditingController feildcontroller;
  Category(this.categoryName, this.value, this.feildcontroller, {super.key});

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
          child: TextField(
            controller: feildcontroller, // ここで初期値を設定
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              // hintText: value,
            ),
            // contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
          ),
        ),
      ],
    );
  }
}

// class ThemeEditor extends StatefulWidget {
//   const ThemeEditor({super.key});

//   @override
//   _ThemeEditorState createState() => _ThemeEditorState();
// }

// class _ThemeEditorState extends State<ThemeEditor> {
//   // // 背景画像パスのリスト
//   // final List<String> bgImgList = [
//   //   bgImg.design0,
//   //   bgImg.design1,
//   //   bgImg.design2,
//   //   bgImg.design3,
//   // ];

//   List<bool> _bgtheme = [true, false, false, false];
//   List<bool> _fonttheme = [true, false, false, false, false];
//   int selectBg = 0;
//   int selectFont = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.9,
//       width: double.infinity,
//       child: Column(
//         children: [
//           Container(
//             height: 11,
//             width: 93,
//             margin: const EdgeInsets.only(top: 20, bottom: 20),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('背景テーマの選択', style: TextStyle(fontSize: 16)),
//               ToggleButtons(
//                 splashColor: Colors.blue[500],
//                 fillColor: Colors.blue[100],
//                 onPressed: (int selectedIndex) {
//                   setState(() {
//                     _bgtheme = List.generate(
//                       _bgtheme.length,
//                       (index) => index == selectedIndex,
//                     );
//                     selectBg = selectedIndex; // 背景テーマの選択
//                   });
//                 },
//                 isSelected: _bgtheme,
//                 children: List.generate(4, (index) => Text('Bg $index')),
//               ),
//               const SizedBox(height: 30),
//               const Text('文字テーマの選択', style: TextStyle(fontSize: 16)),
//               ToggleButtons(
//                 splashColor: Colors.blue[500],
//                 fillColor: Colors.blue[100],
//                 onPressed: (int selectedIndex) {
//                   setState(() {
//                     _fonttheme = List.generate(
//                       _fonttheme.length,
//                       (index) => index == selectedIndex,
//                     );
//                     selectFont = selectedIndex; // 文字テーマの選択
//                   });
//                 },
//                 isSelected: _fonttheme,
//                 children: List.generate(5, (index) => Text('Font $index')),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
    // return WillPopScope(
    //   onWillPop: () async {
    //     // モーダルを閉じる際に値を返す
    //     Navigator.of(context).pop((selectBg, selectFont));
    //     return false;
    //   },
    //   child: Container(
    //     height: MediaQuery.of(context).size.height * 0.9,
    //     width: double.infinity,
    //     child: Column(
    //       children: [
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
    //             const Text('背景テーマの選択', style: TextStyle(fontSize: 16)),
    //             ToggleButtons(
    //               splashColor: Colors.blue[500],
    //               fillColor: Colors.blue[100],
    //               onPressed: (int selectedIndex) {
    //                 setState(() {
    //                   _bgtheme = List.generate(
    //                     _bgtheme.length,
    //                     (index) => index == selectedIndex,
    //                   );
    //                   selectBg = selectedIndex; // 背景テーマの選択
    //                 });
    //               },
    //               isSelected: _bgtheme,
    //               children: List.generate(4, (index) => Text('Bg $index')),
    //             ),
    //             const SizedBox(height: 30),
    //             const Text('文字テーマの選択', style: TextStyle(fontSize: 16)),
    //             ToggleButtons(
    //               splashColor: Colors.blue[500],
    //               fillColor: Colors.blue[100],
    //               onPressed: (int selectedIndex) {
    //                 setState(() {
    //                   _fonttheme = List.generate(
    //                     _fonttheme.length,
    //                     (index) => index == selectedIndex,
    //                   );
    //                   selectFont = selectedIndex; // 文字テーマの選択
    //                 });
    //               },
    //               isSelected: _fonttheme,
    //               children: List.generate(5, (index) => Text('Font $index')),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
//   }
// }

import 'package:cacalia/CS/create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/datas/designData.dart';

// フレンドのプロフィールを取得し表示させる
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
List<String> values = [];

// ignore: non_constant_identifier_names
void Profilemodal(
    BuildContext context, Map<String, dynamic> profileList) async {
  bool isVisible = true; // 初期値
  String fieldName = "suggestion";

  print(profileList);
  List<String> values = []; // リフレッシュ

  // フレンドの該当するプロフィールを取得しvaluesに格納
  for (int i = 0; i < feildnames.length; i++) {
    int currentValue = i;
    String field =
        await getProfileField(profileList["u_id"], feildnames[currentValue]);
    values.add(field);
  }

  // Firestore ドキュメントを取得
  DocumentSnapshot<Map<String, dynamic>> doc = await AIsuggest.get();

  // ドキュメントデータを取得
  Map<String, dynamic>? data = doc.data();

  //AI提案を格納するフィールド
  var suggestdata = data![fieldName];

  String name = profileList["name"];
  String readname = profileList["read_name"];
  String targetBg = '0';
  String targetFont = '0';

  //AI提案表示
  Future<void> AIAdvice() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //ダイアログ表示
        return Dialog(
          //背景色指定
          backgroundColor: const Color(0xFF242B2E),
          shape: RoundedRectangleBorder(
            //ダイアログの角を丸くする
            borderRadius: BorderRadius.all(Radius.circular(13)),
            side: BorderSide(color: Color(0xFFD9D9D9), width: 3.0),
          ),
          child: Column(
            //ダイアログを最小の大きさに変更する
            mainAxisSize: MainAxisSize.min,
            children: [
              //上のバー
              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: const Row(
                  //Mac風のボタンっぽいやつ
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(radius: 5, backgroundColor: Color(0xFFFF5F57)),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 5, backgroundColor: Color(0xFFFEBB2E)),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 5, backgroundColor: Color(0xFF28C840)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '> こんな話題で話してみませんか？',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DotGothic16',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${suggestdata![profileList['u_id']]}\n',
                style: const TextStyle(
                    fontSize: 18,
                    color: Color(0XFF39E329),
                    fontFamily: 'DotGothic16'),
              ),
            ],
          ),
        );
      },
    );
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9, // 高さを動的に設定
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('${profileList['wigetteme']}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Stack(
            alignment: Alignment.topCenter, // 上部中央に配置
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
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Expanded(
                  // スクロール領域を制御
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'about me',
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: '${profileList['chartheme']}',
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 350,
                              margin: const EdgeInsets.only(top: 70),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: '${profileList['chartheme']}'),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 50),
                                    Text(
                                      name,
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      readname,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10), // 余白
                                    // ---------------プロフィールを一覧表示------------------
                                    for (int i = 0; i < keys.length; i++)
                                      Category(keys[i], values[i]),
                                    const SizedBox(
                                      height: 70,
                                    ), // 余白(ボタンで隠れないように)
                                    // ----------------------------------------------------------
                                  ],
                                ),
                              ),
                            ),
                            // ユーザーアイコン
                            Positioned(
                              left: 125,
                              top: 10,
                              child: Container(
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Visibility(
              //     visible: isVisible,
              //     child: AIAdvice(
              //         key_word1: '得意：Flutter',
              //         key_word2: '興味：Go',
              //         key_word3: '参加予定のイベント：技育祭')),
              Container(
                margin: const EdgeInsets.only(top: 720),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //メモボタン
                    SizedBox(
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: Image.asset('assets/images/memo.png'),
                      ),
                    ),
                    const SizedBox(width: 10), //余白
                    //AIボタン
                    SizedBox(
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          AIAdvice();
                        },
                        child: Image.asset('assets/images/ai_button.png'),
                      ),
                    ),
                    const SizedBox(width: 10), //余白
                  ],
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}

//カテゴリーを表示するバー
// ignore: must_be_immutable
class Category extends Container {
  String categoryName;
  String value;

  Category(this.categoryName, this.value, {super.key});

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
        SizedBox(
          height: 100,
          width: 240,
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}

//AI提案の表示
// ignore: non_constant_identifier_names
// class AIAdvice extends Container {
//   String key_word1;
//   String key_word2;
//   String key_word3;

//   AIAdvice(
//       {super.key,
//       required this.key_word1,
//       required this.key_word2,
//       required this.key_word3});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 320,
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10)),
//       child: Container(
//         width: 350,
//         padding: const EdgeInsets.only(bottom: 10),
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(36, 43, 46, 1),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // 子要素に合わせて縦の高さを調整
//           children: [
//             DefaultTextStyle(
//               style: const TextStyle(
//                 fontFamily: 'DotGothic16', // フォントファミリを指定
//                 fontSize: 16, // フォントサイズ
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 16,
//                     width: 350,
//                     padding: EdgeInsets.only(bottom: 20),
//                     color: Colors.grey,
//                     child: Row(),
//                   ),
//                   const Text(
//                     'こんな話題で話してみませんか？',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                   Container(
//                     child: DefaultTextStyle(
//                       style: TextStyle(
//                         color: Colors.green[500],
//                       ),
//                       child: Column(
//                         children: [
//                           Text(key_word1),
//                           Text(key_word2),
//                           Text(key_word3),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

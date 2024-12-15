import 'package:cacalia/CS/create.dart';
import 'package:flutter/material.dart';

// todo フレンドの情報を使う
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
  print(profileList);

  for (int i = 0; i < feildnames.length; i++) {
    int currentValue = i;
    // print(await feildnames[currentValue]);
    // print(await profileList["u_id"]);
    String field =
        await getProfileField(profileList["u_id"], feildnames[currentValue]);
    values.add(field);
  }

  String name = profileList["name"];
  String readname = profileList["read_name"];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9, // 高さを動的に設定
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/design1.png"),
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
                        style: TextStyle(fontSize: 40),
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
                                // Text(
                                //  Text:"", // value
                                //   style: TextStyle(fontSize: 30)
                                // ),
                                // ----------------------------------------------------------
                              ],
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
                      onPressed: () {},
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
    },
  );
}

// ignore: must_be_immutable
class Category extends Container {
  String categoryName;
  String value;

  Category(this.categoryName, this.value);

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

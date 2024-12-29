// プロフィール編集画面
import 'package:cacalia/CS/create.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/editButtons.dart';
import '../../home/pages/home.dart';

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
// List<String> feildelements = [];

class ProfEdit extends StatelessWidget {
  ProfEdit({super.key});

  // 自身の名前と読み仮名
  String name = profileList[myuid]["name"];
  String readname = profileList[myuid]["read_name"];

  // 各フィールド用のコントローラーリストを作成
  final List<TextEditingController> controllers =
      List.generate(feildnames.length, (index) => TextEditingController());

  List<String> values = [];

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
  controllers.forEach((controller) {
  print('Controller text: ${controller.text}');
});
  }

  @override
  Widget build(BuildContext context) {
    // EditButtonsで使用するコントローラーから値を取得する関数
    Future <void> saveValues() async {
      List<String> updatedValues =
          controllers.map((controller) => controller.text).toList();
      print("Updated Values: $updatedValues");
      // ここでupdatedValuesを保存する処理を追加
      for (int i = 0; i < feildnames.length; i++) {
         updateProfile(feildnames[i], updatedValues[i]);
      }
    }

    // 自身のプロフィールを取得するため、描画する前に通信する処理
    return FutureBuilder(
        future: setprofileList(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          } else {
            // 非同期処理が完了したら描画

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/design1.png'),
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
                              child: const Text(
                                'about me',
                                style: TextStyle(fontSize: 40),
                              ),
                              margin: EdgeInsets.only(top: 20),
                            ),
                            EditPen(),
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
                                          EditPen(),
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
            );
          }
        });
  }
}

//カテゴリーのバー
// ignore: must_be_immutable
class Category extends Container {
  String categoryName; // key
  String value; // value
  final TextEditingController feildcontroller;
  Category(this.categoryName, this.value, this.feildcontroller){
    //feildcontroller = TextEditingController(text: value);
  }
  
  @override
  Widget build(BuildContext context) {
    // TextEditingControllerで初期値を設定
    // feildcontroller = TextEditingController(text: value);
    // print(value);
    print(feildcontroller.text);

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

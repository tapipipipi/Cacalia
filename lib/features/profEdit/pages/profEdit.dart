// プロフィール編集画面
import 'package:flutter/material.dart';
import 'package:cacalia/component/editButtons.dart';

class ProfEdit extends StatelessWidget {
  const ProfEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/designs/design1.png'),
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

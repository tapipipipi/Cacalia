import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void Profilemodal(BuildContext context) {
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
                      const Text(
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
                                const Text(
                                  '苗字　名前',
                                  style: TextStyle(fontSize: 24),
                                ),
                                const Text(
                                  'myoji namae',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10), // 余白
                                for (int i = 10; i >= 0; i--) Category('カテゴリー'),
                                const SizedBox(height: 70), // 余白(ボタンで隠れないように)
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
          height: 100,
          width: 240,
        )
      ],
    );
  }
}

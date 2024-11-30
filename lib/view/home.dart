import 'package:flutter/material.dart';
import 'package:cacalia/component/card.dart';
import 'package:cacalia/component/footer.dart';

//StatelessWidget:静的なウィジェット
class Home extends StatelessWidget {
  // ignore: unused_field
  final ScrollController _controller = ScrollController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    //画面全体のウィジェット
    return Scaffold(
      appBar: AppBar(
        // titleを画像に設定
        title: Image.asset(
          'assets/images/cacalia.png',
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(215, 230, 239, 1),
        actions: [
          // ignore: sized_box_for_whitespace
          Container(
            height: 47,
            width: 47,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  spreadRadius: 0, //広がりを最小
                  blurRadius: 1, //ぼかしの強さ
                  offset: Offset(0, 5), // 影の位置を指定
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(17, 90, 132, 1),
                shape: const CircleBorder(),
                // minimumSize: Size(47, 47), // ボタンサイズを親Containerに合わせる
                padding: EdgeInsets.zero, // パディングをゼロに
              ),
              onPressed: () {},
              child: Image.asset('assets/images/exchangeBtn.png'),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(215, 230, 239, 1),
        width: double.infinity, //全範囲選択
        height: double.infinity,
        child: Column(
          children: [
            // 名刺一覧
            Container(
              width: 337,
              height: 669,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(69, 76, 80, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  //検索ボックスを含む上部分
                  Container(
                    height: 53,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(110, 119, 124, 1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(161, 161, 161, 1),
                      ),
                    ),
                    // 検索ボックス
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 240,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '検索',
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              filled: true,
                              fillColor: const Color.fromRGBO(161, 161, 161, 1),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Image.asset('assets/images/sort.png'),
                      ],
                    ),
                  ),
                  //名刺一覧
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < 5; i++) UserCard(userId: i),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

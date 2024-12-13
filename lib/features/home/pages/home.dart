import 'package:flutter/material.dart';
import 'package:cacalia/component/card.dart';
import 'package:cacalia/component/footer.dart';
import 'package:cacalia/component/profileModal.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isVisible = false; // 初期値

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/cacalia.png',
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(215, 230, 239, 1),
        actions: [
          Container(
            height: 47,
            width: 47,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            // 交換ボタン
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(17, 90, 132, 1),
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                context.go('/exchange');
              },
              child: Image.asset('assets/images/exchangeBtn.png'),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(215, 230, 239, 1),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: 337,
              height: 669,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(69, 76, 80, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
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
                        // 検索バー
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 25,
                              width: 240,
                              margin: const EdgeInsets.only(left: 15),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '検索',
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(161, 161, 161, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(161, 161, 161, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(toggleShowText);
                              },
                              icon: Image.asset('assets/images/sort.png'),
                            ),
                          ],
                        ),
                      ),
                      //sortのダイアログ
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          height: 139,
                          width: 285,
                          margin: const EdgeInsets.only(top: 0, left: 28),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(69, 76, 80, 1),
                            // border:
                          ),
                        ),
                      ),
                    ],
                  ),
                  //名刺一覧
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20, right: 30),
                      itemCount: 5, // サンプルとして5枚の名刺を表示
                      itemBuilder: (context, index) {
                        return Transform.translate(
                            offset: Offset(0, -index * 30.0), // カードを重ねて表示
                            child: InkWell(
                              child: UserCard(userId: index),
                              onTap: () {
                                Profilemodal(context);
                              },
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }

  //sort押した時のダイアログ？表示の操作
  void toggleShowText() {
    isVisible = !isVisible;
  }
}

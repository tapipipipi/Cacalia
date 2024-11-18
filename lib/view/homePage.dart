import 'package:flutter/material.dart';
import 'package:cacalia/component/card.dart';

//StatelessWidget:静的なウィジェット
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //画面全体のウィジェット
    return Scaffold(
      appBar: AppBar(
        // titleを画像に設定
        title: Image.asset(
            '../assets/images/cacalia.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(215, 230, 239, 1),
      ),
      body: Container(
        color: Color.fromRGBO(215, 230, 239, 1),
        width: double.infinity, //全範囲選択
        height: double.infinity,
        child: Column(
          children: [
            // 交換ボタン
            SizedBox(
              height: 47,
              child: ElevatedButton(
                child: Image.asset('../assets/images/exchangeBtn.png'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(17, 90, 132, 1),
                  shape: CircleBorder(),
                ),
                onPressed: () {},
              ),
            ),
            // 名刺一覧
            Container(
              width: 337,
              height: 669,
              decoration: BoxDecoration(
                color: Color.fromRGBO(69, 76, 80, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    height: 53,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(110, 119, 124, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Color.fromRGBO(161, 161, 161, 1),
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
                              prefixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(161, 161, 161, 1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                          ),
                        ),
                        Image.asset('../assets/images/sort.png'),
                      ],
                    ),
                  ),
                  UserCard(userName: '文元 沙弥'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
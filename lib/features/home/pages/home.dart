import 'package:cacalia/CS/profile.dart';
import 'package:cacalia/store.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/card.dart';
import 'package:cacalia/component/footer.dart';
import 'package:cacalia/component/profileModal.dart';
<<<<<<< HEAD
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../Auth/Authentication.dart';
import '../../../CS/create.dart';
=======
import 'package:go_router/go_router.dart';
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c

class Home extends StatefulWidget {
  // ここにイニシャライザを書く
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

List<String> friends = []; // friend一覧格納
Map<String, dynamic> profileList = {}; // fidに対応するプロフィール一覧を格納
List<List<Object>> cardList = []; // card使用するデータをfriendの数だけ用意
List<Object> addList = []; // cardList追加時に使用

String fid = "";
//uid取得
String myuid = Authentication().getuid();

// Future getcard() async {
//   friends = await (getFriends());

//   for (int i = 0; i < friends.length; i++) {
//     fid = friends[i];
//     profileList[fid] = await (getProfile(fid)); // fidに対応するプロフィールをすべて取得

//     // addListを毎回新しく作成
//     List<Object> addList = [];
//     addList.add(profileList[fid]["name"]);
//     addList.add(profileList[fid]["read_name"]);
//     // print(addList);
//     // cardListに追加
//     cardList.add(addList);
//   }

//   // print(cardList);
//   // return cardList;
// }



// int itemcount = friends.length;



class _HomeState extends State<Home> {
<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    fetchCardData(); // 非同期データを初期化時に取得
  }

  Future<void> fetchCardData() async {
    await getcard();
    setState(() {}); // データ取得後にUIを更新
  }

  Future<void> getcard() async {
  friends = await getFriends();

  for (int i = 0; i < friends.length; i++) {
    fid = friends[i];
    profileList[fid] = await getProfile(fid);

    // 毎回新しいリストを作成して追加
    List<Object> addList = [
      profileList[fid]["name"],
      profileList[fid]["read_name"],
    ];
    cardList.add(addList);
  }

  // 状態を更新
  setState(() {});
}

  final ScrollController _controller = ScrollController();
=======
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c
  bool isVisible = false; // 初期値

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    if (mounted) {
      if (friends.isEmpty || cardList.isEmpty) {
        return Center(child: CircularProgressIndicator()); // ローディング中
      }
      return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/cacalia.png',
=======
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
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c
          ),
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(215, 230, 239, 1),
          actions: [
            Container(
<<<<<<< HEAD
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
=======
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
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(17, 90, 132, 1),
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Image.asset('assets/images/exchangeBtn.png'),
              ),
            ),
          ],
        ),
<<<<<<< HEAD
        body: Container(
          color: const Color.fromRGBO(215, 230, 239, 1),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                width: 337,
                height: 669,
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
                                // todo フィルター
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
                        padding: const EdgeInsets.all(20),
                        itemCount: cardList.length, // フレンドの数だけ表示
                        itemBuilder: (context, index) {
                          return Transform.translate(
                              offset: Offset(0, -index * 30.0), // カードを重ねて表示
                              child: InkWell(
                                child: UserCard(userId: index
                                    // friendsCardList: cardList,
                                    ),
                                onTap: () {
                                  // friends[index] をキーに profileList から該当データを取得
                                  var selectedProfile = profileList[friends[index]];
                                  Profilemodal(context, selectedProfile);
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
        bottomNavigationBar: const Footer(),
      );
    } else {
      return Scaffold();
    }
=======
      ),
      bottomNavigationBar: Footer(),
    );
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c
  }

  //sort押した時のダイアログ？表示の操作
  void toggleShowText() {
    isVisible = !isVisible;
  }
}

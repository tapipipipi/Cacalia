import 'package:cacalia/store.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/card.dart';
import 'package:cacalia/component/footer.dart';
import 'package:cacalia/component/profileModal.dart';
import '../../../Auth/Authentication.dart';
import '../../../CS/create.dart';
import 'package:go_router/go_router.dart';

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
int mycard = 0;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    print(uid);
    getProfile(uid);
    fetchCardData(); // 非同期データを初期化時に取得
  }

  Future<void> fetchCardData() async {
    await getcard();
    setState(() {}); // データ取得後にUIを更新
  }

  // cardListにフレンドごとの名前と読みを追加していく
  Future<void> getcard() async {
    print("getcard()");
    cardList = []; // リフレッシュ
    profileList = {}; // リフレッシュ
    friends = await getFriends();

    print("get cards.");
    for (int i = 0; i < friends.length; i++) {
      fid = friends[i];
      profileList[fid] = await getProfile(fid);

      // 毎回新しいリストを作成して追加(リフレッシュ)
      List<Object> addList = [
        profileList[fid]["name"],
        profileList[fid]["read_name"],
      ];
      cardList.add(addList);
    }
  
    // 最終的にできるcardlistの最後尾を代入
    mycard = cardList.length;

    // 自身のプロフィールを獲得しcardlistに追加
    profileList[myuid] = await getProfile(myuid);
    List<Object> addList = [
      profileList[myuid]["name"],
      profileList[myuid]["read_name"],
    ];
    cardList.add(addList);

    // 状態を更新
    setState(() {});
  }

  final ScrollController _controller = ScrollController();
  bool isVisible = false; // 初期値

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      if (friends.isEmpty || cardList.isEmpty) {
        return Center(child: CircularProgressIndicator()); // ローディング中
      }
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
                                    hintStyle: const TextStyle(
                                        fontFamily: 'DotGothic16'),
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
                        padding: const EdgeInsets.only(top: 20),
                        itemCount: mycard, // フレンドの数だけ表示
                        itemBuilder: (context, index) {
                          return Transform.translate(
                              offset: Offset(0, -index * 30.0), // カードを重ねて表示
                              child: InkWell(
                                child: UserCard(userId: index, state: true),
                                onTap: () {
                                  // friends[index] をキーに profileList から該当データを取得
                                  var selectedProfile =
                                      profileList[friends[index]];
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
        bottomNavigationBar: Footer(),
      );
    } else {
      return Scaffold();
    }
  }

  //sort押した時のダイアログ？表示の操作
  void toggleShowText() {
    isVisible = !isVisible;
  }
}

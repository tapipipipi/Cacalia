// 掲示板画面
import 'package:cacalia/component/tweet.dart';
import 'package:cacalia/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cacalia/component/footer.dart';
import '../../../Auth/Authentication.dart';
import '../../../CS/create.dart';
import 'package:go_router/go_router.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  _TimelineState createState() => _TimelineState();
}

List<String> friends = []; // friend一覧格納
Map<String, dynamic> tweetList = {}; // fidに対応するツイート一覧を格納
Map<String, dynamic> tweetList2 = {}; // fidに対応するツイート一覧を格納
List<List<Object>> postList = []; // 並べ替えたい
List<List<Object>> tweets = [];

Map<String, dynamic> cont = {};

// Map<String, dynamic> testob = {};
// Map<String, dynamic> testadd = {};
// List<Object> addList = []; // cardList追加時に使用

String fid = "";
//uid取得
String myuid = Authentication().getuid();
int posts = 0; // postの数
int itemC = 0; // tweet.dartで表示する枚数を指定

class _TimelineState extends State<Timeline> {
  bool isLoading = true; // ローディング状態を管理する変数

  @override
  void initState() {
    super.initState();
    fetchCardData(); // 非同期データを初期化時に取得
  }

  Future<void> fetchCardData() async {
    await gettweet();

    itemC = posts;

    if (mounted) {
      // mountedがtrueかどうかを確認
      setState(() {
        isLoading = false; // データ取得完了後にローディング終了
      }); // データ取得後にUIを更新
    }
  }

  // postListにフレンドごとのtweetを追加していく
  Future<void> gettweet() async {
    print("gettweet()");
    tweetList = {}; // リフレッシュ
    postList = []; // リフレッシュ]
    tweets = [];
    posts = 0;

    friends = await getFriends();

    if (friends.isEmpty) {
      print("null");
    } else {
      for (int i = 0; i < friends.length; i++) {
        fid = friends[i];
        print(fid);
        tweetList[fid] = await getT_ids(fid); // fid:{tid,tid,...}  ->　配列にならない問題
        print(tweetList);

        // ーーーーーーー毎回新しいリストを作成して追加(リフレッシュ)ーーーーーーーーーーーーーーーーーーーーーーーーーー

        // ☆------配列の場合文字列に変換(ホンマは配列にする)-------
        // var arry = (tweetList[fid]["t_ids"] is List)
        //     ? (tweetList[fid]["t_ids"] as List).join(",") // 文字列に変換
        //     : tweetList[fid]["t_ids"];

        // --------------------------------------------------

        var arry = (tweetList[fid]["t_ids"] is List)
            ? List<String>.from(
                tweetList[fid]["t_ids"] as List) // `List<String>` に変換
            : [tweetList[fid]["t_ids"].toString()]; // 文字列をリストに変換

        if (!arry.isEmpty) {
          //　投稿があれば追加
          print("arry is not empty");
          List<Object> addList = [fid, arry]; // ☆

          postList.add(addList);

          print(postList);

          //-------------------------
          // String feild = postList[i][1] as String;// ☆

          var by_u_postList = postList[i][1] as List<String>;
          print(by_u_postList);

          print("by_u_postList is not empty");
          for (int l = 0; l < by_u_postList.length; l++) {
            if (by_u_postList[l] != "") {
              // List<String> list = by_u_postList[l] as List<String>;

              String feild = by_u_postList[l];
              print(feild); // tid

              tweetList2 = await getTweet(fid, feild);
              print(
                  tweetList2); // {name: ECC太郎, tweet: 投稿１, timestamp: Timestamp(seconds=1738689220, nanoseconds=823000000)}
              List<Object> add2List = [
                tweetList2["name"],
                tweetList2["tweet"],
                tweetList2["timestamp"]
              ];
              print(add2List);
              tweets.add(add2List);
              posts++;
            }
          }
        }

        //------------------------------------------
      }
    }

    print(tweets);

    // tweets.sort((a, b) => (b[2] as DateTime).compareTo(a[2] as DateTime));
    tweets.sort((a, b) => (b[2] as Timestamp).toDate().compareTo((a[2] as Timestamp).toDate()));

    print(tweets);

    // 並び替えます

    // 状態を更新
    setState(() {});
  }

  final ScrollController _controller = ScrollController();
  bool isVisible = false; // 初期値

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // データ取得中はローディング画面を表示
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/cacalia.png',
        ),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(215, 230, 239, 1),
      ),
      //自分のアイコンがうまく表示されない
      // leading: Container(
      //   height: 47,
      //   padding: const EdgeInsets.only(left: 20), // アイコンとの間にスペースを追加
      //   margin: const EdgeInsets.only(left: 45), // 左に空間を追加
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: const Color.fromRGBO(17, 90, 132, 1),
      //       shape: const CircleBorder(),
      //       padding: EdgeInsets.zero,
      //     ),
      //     onPressed: () {
      //       context.go('/exchange');
      //     },
      //     child: Image.asset(
      //       'assets/images/exchangeBtn.png',  // 画像アイコンを指定
      //       height: 40,  // アイコンの高さ
      //       width: 40,   // アイコンの幅
      //       fit: BoxFit.contain,  // 画像がつぶれないように調整
      //     ),
      //   ),
      // ),

      body: Container(
        color: const Color.fromRGBO(215, 230, 239, 1),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // ここでRowを追加
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1つ目のTextをInkWellでラップ
                InkWell(
                  onTap: () {
                    context.go('/ask');
                  },
                  child: Text(
                    '質問', // ここに表示したい文字を入れる
                    style: TextStyle(
                      fontSize: 16,

                      fontWeight: FontWeight.bold,
                      color: Color(0xff115A84), // 文字の色を設定
                    ),
                  ),
                ),
                SizedBox(width: 60), // テキスト間のスペース
                InkWell(
                  onTap: () {},
                  child: Text(
                    '投稿',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff115A84), // 文字の色を設定
                    ),
                  ),
                ),
                SizedBox(width: 60), // テキスト間のスペース
                // 3つ目のTextをInkWellでラップ
                InkWell(
                  onTap: () {
                    context.go('/recruitment');
                  },
                  child: Text(
                    '募集', // ここに表示したい文字を入れる
                    style: TextStyle(
                      fontSize: 16,

                      fontWeight: FontWeight.bold,
                      color: Color(0xff115A84), // 文字の色を設定
                    ),
                  ),
                ),
              ],
            ),
            // Rowの下に引く線
            Container(
              height: 1, // 線の太さ
              color: Colors.grey, // 線の色
              width: 250, // 幅を親コンテナに合わせる
            ),
            SizedBox(
              height: 53,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 300,
                    margin: const EdgeInsets.only(left: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '検索',
                        hintStyle: const TextStyle(fontFamily: 'DotGothic16'),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(161, 161, 161, 1)),
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     setState(toggleShowText);
                  //   },
                  //   icon: Image.asset('assets/images/sort.png'),
                  // ),
                ],
              ),
            ),
            Container(
              width: 337,
              height: 600,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Stack(
                    children: [
                      //sortのダイアログ
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          height: 139,
                          width: 285,
                          margin: const EdgeInsets.only(top: 0, left: 28),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(69, 76, 80, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20),

                      itemCount: itemC, // フレンドの数だけ表示

                      itemBuilder: (context, index) {
                        return Transform.translate(
                          offset: const Offset(0, 0),
                          child: ClipRRect(
                            child: InkWell(
                              child: Tweet(userId: index, tweet: true),
                            ),
                          ),
                        );
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

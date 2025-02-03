import '../../../CS/create.dart';
import 'package:go_router/go_router.dart';
import '../../home/pages/home.dart';

List<String> f = [];
Map<String, dynamic> postList = {}; // fidに対応するtweet覧を格納
List<List<Object>> tweetList = []; // 使用するデータをfriendの数だけ用意
// List<Object> addList = []; // tweetList追加時に使用

Future<void> getposts() async {
  print("getposts()");
  
  f = await getFriends();
  postList = {}; // リフレッシュ
  tweetList = []; // リフレッシュ
  

  if ( f != null) {
    print("get");
    for (int i = 0; i < f.length; i++) {
      fid = f[i];
      postList[fid] = await getPost(fid);

      // 毎回新しいリストを作成して追加(リフレッシュ)
      List<Object> addList = [
        postList[fid]["tweet"],
        profileList[fid]["timestamp"],
      ];
      tweetList.add(addList);
    }
    }

    // 最終的にできるcardlistの最後尾を代入
    // mycard = cardList.length;

    // 自身のプロフィールを獲得しcardlistに追加
    // profileList[myuid] = await getProfile(myuid);
    // List<Object> addList = [
    //   profileList[myuid]["name"],
    //   profileList[myuid]["read_name"],
    // ];
    // cardList.add(addList);

    // 状態を更新
    // setState(() {});
}

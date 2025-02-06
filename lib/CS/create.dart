import 'package:cacalia/component/profileModal.dart';
import 'package:cacalia/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

//UUIDを作成するライブラリ
import 'package:uuid/uuid.dart';

/// import 'package:firebase_auth/firebase_auth.dart';
String friend = "friends"; // コレクション、ドキュメント指定用 /users/friends/friends
String tweet = "tweets";
String profile = "profile";
String users = "users"; // コレクション指定用 /users
String ini = ""; // 本番用 profileの初期値
String g_doc = ""; // テスト用　将来的にはuid
String g_colle = ""; // テスト用

//Uuidを生成
var uuid = Uuid();

/// db定義
final db = FirebaseFirestore.instance;

/// collectionとdocmentを指定
final mycollection = db // コレクション名、usersは固定にしてuserごとにコレクション持たせる方針で行こうかな。
    .collection(users)
    .doc(uid);
final myfriends = mycollection.collection(friend).doc(friend);
final mytweets = mycollection.collection(tweet);

// final createuser = db.collection(users).doc("aVhf5tTSWNRAmFAaikon0hyl08C3");

/// 質問、投稿、募集は未作成
// final createuser = db.collection(users).doc("aVhf5tTSWNRAmFAaikon0hyl08C3");

/// 性別 いらんかも
final gender = <String, dynamic>{
  "0": "male", // 男性
  "1": "femail", // 女性
  "2": "others" // その他
};

/// interestとskillsで使用、いらんかも
/// 構造相談
final field = <String, dynamic>{
  "0": "db",
  "1": "network",
  "2": "design",
  "3": "IoT",
  "4": "front",
  "5": "back",
  "others": "その他" // 自由記述?
};

/// ---------------コレクション-------------

/// 「＊」は自由記述
/// 2230360@ecc.ac.com   Hxva1aGnNMcwg8s7esKDNmNll6u1
/// 2210089@ecc.com フカ eNWeRyxoF1TQcUicEWn25SyZN1p2
/// 2230192@ecc.com ふみ f8MQVKc4hbMe4z9Gtu3Sz2ZLn123
/// 2230329@ecc.com　ば
/// 2230358@ecc.com 谷
/// 誕生日とかの設定が未解決問題
/// どこで設定するか
///  -> 名前と読み仮名は名詞で編集すると思われ
Map<String, dynamic> profiles = <String, dynamic>{
  //　初期設定
  "u_id": uid,
  "name": "ECC 太郎",
  "read_name": "ECC taro",
  "gender": "f",
  "age": "0",
  "comment": "よろしくお願いします！！",
  "events": "HACK_U",
  "belong": "ECCコンピュータ専門学校",
  "skill": "MySQL",
  "interest": "Mongo",
  "hoby": "山登り",
  "background": "ハッカソン企業賞獲得しました！",
  "bairth": "1/1",
  "serviceUuid": "forble",
  "charactaristicuuid": "forble",
  "wigetteme": "1", // テーマカラー
  "chartheme": "1" // 字体
};

// uid 格納していくスタイル
Map<String, dynamic> friends = <String, dynamic>{"friend_uid": []};
Map<String, dynamic> tweets = <String, dynamic>{"t_ids": []};

/// ---------------------------------------

/// コレクションprofile作成(サインインアップ後一度だけ呼び出される)
void setUser(String uid) {
  print("setuser()");
  profiles["u_id"] = uid;
  db
      .collection(users)
      .doc(uid)
      // 第二引数なくてもいい
      // 　同じドキュメントにset()メソッドを呼び出した際に
      // 　false -> 既存のデータを消して上書きするか
      // 　true - > 追加して保存するかを設定する。
      .set(profiles, SetOptions(merge: true))
      .onError((e, _) => print("Error writing document: $e")); // errMessage
}

/// サブコレクションfriends作成(サインインアップ後一度だけ呼び出される)
void setFriend() {
  myfriends
      .set(friends, SetOptions(merge: true))
      .onError((e, _) => print("Error writing document: $e")); // errMessage
}

/// サブコレクションtweets作成(サインインアップ後一度だけ呼び出される)
void setTweets() {
  mytweets
      .doc(tweet)
      .set(tweets, SetOptions(merge: true))
      .onError((e, _) => print("Error writing document: $e")); // errMessage
}

// 投稿する際に呼び出す
void postTweet(String tweet) {
  print("setTweets");
  Map<String, dynamic> tweets = <String, dynamic>{
    "tweet": tweet,
    "timestamp": Timestamp.now()
  };
  String tuid = generateUid(); // t_uid
  mytweets
      .doc(tuid)
      .set(tweets, SetOptions(merge: true))
      .onError((e, _) => print("Error writing document: $e")); // errMessage

  updateTweet(tuid);
}

/// データ更新　プロフィール編集時に使用
/// update( {更新したいカラム : 値} )
/// 今回transactionを使用しない(あったほうがオシャレやけど)
void updateProfile(String key, String val) {
  mycollection.update({key: val}).then((value) => print("update sucessed"),
      onError: (e) => print("Error updating document $e"));
}

/// 通信(名刺交換)後に呼び出し.valは通信の際に受け取ったデータ(uid)を代入
updateFriend(String key, String val) {
  myfriends.update({
    key: FieldValue.arrayUnion([val])
  }).then((value) => print("update sucessed"),
      onError: (e) => print("Error updating document $e"));
}

///
updateTweet(String val) {
  mytweets.doc(tweet).update({
    "t_ids": FieldValue.arrayUnion([val])
  }).then((value) => print("update sucessed"),
      onError: (e) => print("Error updating document $e"));
}

//投稿に呼び出される
// updateTweet(String tweet, Timestamp time) {
//   print("upTweet");
//   mytweets.update({tweet: time}).then((value) => print("update sucessed"),
//       onError: (e) => print("Error updating document $e"));
// }

///　削除　使わんかも
/// delete()
void deleteDoc() {
  myfriends.delete().then(
        (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}

/// データ取得　ホーム画面　プロフィール表示に使用
/// get()
/// ドキュメントの内容をマップとして取得 {key1: value2, key2: value2,  ...}

/// select * from コレクション いらんかな
void selectAll() {
  db.collection(users).doc(uid).collection(friend).get().then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        // docSnapshot.id     -> ドキュメント名
        // docSnapshot.data() -> select *
        print('${docSnapshot.data()}');
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

/// プロフィールの一覧を取得
Future<Map<String, dynamic>> getProfile(String uid) async {
  try {
    print("getprofile");
    // Firestore ドキュメントを取得
    DocumentSnapshot<Map<String, dynamic>> doc =
        await db.collection(users).doc(uid).get();

    // ドキュメントが存在しない場合、ドキュメントを作成
    if (!doc.exists || doc.data() == null) {
      print(uid);
      setUser(uid); // userprofike作成
      setFriend(); // freendlist作成
      setTweets();
      print("serUser()successed");
      throw Exception('Document does not exist or has no data');
    }
    return doc.data()!;
  } catch (e) {
    print('Error getting profile: $e'); // エラーをキャッチ
    return <String, dynamic>{};
  }
}

/// プロフィールの一覧を取得
/// ドキュメントから取得

Future<Map<String, dynamic>> getTweet(String uuid, String tid) async {
  try {
    print("gettweet");
    // Firestore ドキュメントを取得
    DocumentSnapshot<Map<String, dynamic>> doc =
        await db.collection(users).doc(uuid).collection(tweet).doc(tid).get();

    // ドキュメントが存在しない場合、ドキュメントを作成
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document does not exist or has no data');
    }
    return doc.data()!;
  } catch (e) {
    print('Error getting profile: $e'); // エラーをキャッチ
    return <String, dynamic>{};
  }
}

//ユーザのUUIDを生成
_generateUuids() {
  String serviceUuid = uuid.v4();
  String charactaristicuuid = uuid.v4();
  print(serviceUuid);
  print(charactaristicuuid);
  updateProfile("serviceUuid", serviceUuid);
  updateProfile("charactaristicuuid", charactaristicuuid);
  print('UUIDを作成しました');
}

// uid 生成
String generateUid() {
  return uuid.v4();
}

/// フレンドのuid一覧を取得
/// フィールドから値を取得
Future<String> getProfileField(String uid, String field) async {
  try {
    // Firestore ドキュメントを取得
    DocumentSnapshot<Map<String, dynamic>> doc =
        await db.collection(users).doc(uid).get();

    // ドキュメントが存在するか確認
    if (doc.exists && doc.data() != null) {
      // データを取得して指定フィールドの値を返す
      Map<String, dynamic> record = doc.data()!;
      return record[field] as String;
    } else {
      print('Document does not exist or has no data');
      return "no data"; // データがない場合
    }
  } catch (e) {
    print('Error getting profile: $e'); // エラーをキャッチ
    return "err";
  }
}

// １つのユーザーの投稿を取得 (投稿が増えるにつれデータの構造変えないとこのままではまずいが一旦保留)
// Future<Map<String, dynamic>> getTweets(String t_id) async {
//   print("getTweet");
//   try {
//     // Firestore ドキュメントを取得
//     DocumentSnapshot<Map<String, dynamic>> doc =
//         await db.collection(users).doc(uid).collection(tweet).doc(t_id).get();

//     // ドキュメントが存在するか確認
//     if (doc.exists && doc.data() != null) {
//       // データを取得して指定フィールドの値を返す
//       print(doc.data());
//       Map<String, dynamic> record = doc.data()!;
//       return record;
//     } else {
//       throw Exception('Document does not exist or has no data'); // データがない場合
//     }
//   } catch (e) {
//     print('Error getting tweet: $e'); // エラーをキャッチ
//     return {};
//   }
// }

/// home.dartに移行時に呼び出される
Future<Map<String, dynamic>> getT_ids(String uid) async {
  String fieldName = "t_ids";
  print("getT_ids");

  try {
    // Firestore ドキュメントを取得
    //QuerySnapshot querySnapshot = await mytweets.get();

    DocumentSnapshot<Map<String, dynamic>> doc =
        await db.collection(users).doc(uid).collection(tweet).doc(tweet).get();

    return doc.data()!;
  } catch (e) {
    print("Error: $e");
    return {};
  }
}

/// 名詞一覧の際にユーザーのフレンドのuidを配列で返す.
/// home.dartに移行時に呼び出される
Future<List<String>> getFriends() async {
  String fieldName = "friend_uid";
  print("getfriend");
  try {
    // Firestore ドキュメントを取得
    DocumentSnapshot<Map<String, dynamic>> doc = await myfriends.get();
    // DocumentSnapshot<Map<String, dynamic>> test =
    //     await db.collection(users).doc("");
    // ドキュメントデータを取得
    Map<String, dynamic>? data = doc.data();

    // 配列フィールドを取り出す
    if (data![fieldName] != null) {
      return (data[fieldName] as List<dynamic>).cast<String>();
    } else {
      throw Exception("Field $fieldName does not exist or is null");
    }
  } catch (e) {
    print("err: $e");
    return [];
  }
}

/// 未
/// filtter検索で使うだろう
/// 名前でフィルターする感じかな
/// select * from コレクション where name = sample;
void selectWhere() {
  db
      .collection(users) //　コレクション名
      .where("name", isEqualTo: "sample")
      .get()
      .then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.data()}');
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

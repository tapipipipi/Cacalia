import 'package:cloud_firestore/cloud_firestore.dart';

/// import 'package:firebase_auth/firebase_auth.dart';
String friend = "friend";
String profile = "profile";
String ini = ""; // 本番用 profileの初期値
String g_doc = ""; // テスト用　将来的にはuid
String g_colle = ""; // テスト用

/// db定義
final db = FirebaseFirestore.instance;

/// collectionとdocmentを指定
final mycollection = db // コレクション名、usersは固定にしてuserごとにコレクション持たせる方針で行こうかな。
    .collection("users")
    .doc(g_doc);
final myfriends = mycollection.collection(friend).doc(friend);

/// 質問、投稿、募集は未作成

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
/// 2230360@ecc.ac.com Hxva1aGnNMcwg8s7esKDNmNll6u1
/// 2210089@ecc.com フカ eNWeRyxoF1TQcUicEWn25SyZN1p2
/// 2230192@ecc.com ふみ f8MQVKc4hbMe4z9Gtu3Sz2ZLn123
/// 2230329@ecc.com　ば
/// 2230358@ecc.com 谷
final profiles = <String, dynamic>{
  "u_id": g_doc, // いらんかも
  "name": "文元　沙弥", //1
  "read_name": " Fumimoto Saya", // 2
  "gender": "1", //3
  "age": 2004, //4
  "comment": "ダーツ友達ください", // ＊5
  "events": "HACK U", // ＊6
  "belong": "ECCコンピュータ専門学校", // ＊7
  "interest": "0",
  "skill": "0",
  "hoby": "カラオケ", // ＊8
  "background": "何入れたら良いかわからんかったから適当に", // ＊9
  "bairth": "05/14", // 10 後でやる
  "serviceUuid": "forBLE",
  "charactaristicuuid": "forBLE"
};

// uid 格納していくスタイル
final friends = <String, dynamic>{"friend_uid": []};

/// ---------------------------------------

/// コレクションprofile作成(サインインアップ後一度だけ呼び出される)
void setUser() {
  mycollection
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

/// add()

/// データ更新　プロフィール編集時に使用
/// update( {更新したいカラム : 値} )
/// 今回transactionを使用しない(あったほうがオシャレやけど)
void updateProfile(String key, String val) {
  mycollection.update({key: val}).then((value) => print("update sucessed"),
      onError: (e) => print("Error updating document $e"));
}

/// 通信(名刺交換)後に呼び出し.valは通信の際に受け取ったデータ(uid)を代入
void updateFriend(String key, String val) {
  myfriends.update({
    key: FieldValue.arrayUnion([val])
  }).then((value) => print("update sucessed"),
      onError: (e) => print("Error updating document $e"));
}

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
  db.collection("users").get().then(
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

/// 名詞一覧で使うだろう
/// select * from freiends where doc = g_doc;
void selectDoc() {
  myfriends.get().then(
    (DocumentSnapshot doc) {
      final result = doc.data() as Map<String, dynamic>;
      print(result); // 結果を出力
    },
    onError: (e) => print("Error getting document: $e"),
  );
}

/// 未
/// filtter検索で使うだろう
/// select * from コレクション where name = sample;
void selectWhere() {
  db
      .collection("users") //　コレクション名
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

import 'package:cloud_firestore/cloud_firestore.dart';

/// import 'package:firebase_auth/firebase_auth.dart';

/// db定義
final db = FirebaseFirestore.instance;

/// collectionとdocmentを指定
final collection =
    db.collection("users") // コレクション名、usersは固定にしてuserごとにコレクション持たせる方針で行こうかな。
    // .doc("newuser1")  // ドキュメント名
    ;

String g_doc = ""; // テスト用
String g_colle = ""; // テスト用

/// UserIDの取得(auth) -> docに代入せよ
/// final userID = FirebaseAuth.instance.currentUser?.uid ?? 'test';

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

/// ---------------コレクション(users)-------------

final user = <String, dynamic>{
  "pass": "pass2", // いらんかも
  "name": "sample",// いらんかも
  "email": "e@e", //いらんかも
};

/// 「＊」は自由記述
final profile = <String, dynamic>{
  "pro_id": "sample", // いらんかも
  // "img_pass": "sample",  //いるかも?
  "name": "テスト", //1
  "gender": "0", //2
  "age": 2024, //3
  "comment": "好きな犬は柴犬です", // ＊4
  "events": "ハッカソン", // ＊5
  "belong": "所属", // ＊6
  "interest": "0",
  "skill": "0",
  "hoby": "趣味", // ＊9
  "background": "ハッカソン関西制覇", // ＊10
  "bairth": "12/25", // 後でやる
  "read_name": "yomigana" // ＊12
};

final friends = <String, dynamic>{
  "friend_id": "sample"
};

/// ---------------------------------------

/// データ追加 アカウント作成 (*こいつはドキュメントの指定は必要ない*)、プロフィール作成、フレンド追加時に使用
/// set( 追加したいデータ )
void setDoc() {
  collection
      .doc(g_doc)
      // 第二引数なくてもいい
      // 　同じドキュメントにset()メソッドを呼び出した際に
      // 　false -> 既存のデータを消して上書きするか
      // 　true - > 追加して保存するかを設定する。
      .set(profile, SetOptions(merge: false))
      .onError((e, _) => print("Error writing document: $e")); // errMessage
}
/// add()


/// データ更新　プロフィール編集時に使用
/// update( {更新したいカラム : 値} )
/// 今回transactionを使用しない(あったほうがオシャレやけど)
void updateDoc(String key, String val) {

// アカウントコレクションが必要な場合
// collection
//       .doc(g_doc)
//       .collection(g_colle)
//       .doc(g_colle)
//       .update({key: val}).then((value) => print("update sucessed"),
//           onError: (e) => print("Error updating document $e"));

// 必要ない場合
collection
      .doc(g_doc)
      .update({key: val}).then((value) => print("update sucessed"),
          onError: (e) => print("Error updating document $e"));
}

///　データ削除　使わんかも
/// delete()
void deleteDoc() {
collection
      .doc(g_doc) // 消したいドキュメント
      .delete()
      .then(
        (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}

/// データ取得　ホーム画面　プロフィール表示に使用
/// get()
/// ドキュメントの内容をマップとして取得 {key1: value2, key2: value2,  ...}

/// select * from コレクション いらんかな
void selectAll() {
  collection
      .get()
      .then(
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
  collection.doc(g_doc).collection(g_colle).doc(g_colle).get().then(
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

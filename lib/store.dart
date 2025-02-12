import 'package:cacalia/CS/profile.dart';
import 'package:flutter/material.dart';
import 'CS/create.dart';
import 'Auth/Authentication.dart';

// コレクション＝テーブル
// ドキュメント＝データ
// このページではdbの操作を行う。ボタンを押すとそれぞれの処理が実行される

class Store extends StatelessWidget {
  const Store({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CS test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyFirestorePage(),
    );
  }
}

class MyFirestorePage extends StatefulWidget {
  const MyFirestorePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyFirestorePageState createState() => _MyFirestorePageState();
}

final colleController = TextEditingController();
final docController = TextEditingController();
final friendController = TextEditingController();
final getController = TextEditingController();

final uid = Authentication().getuid(); // uid取得
String friendid = "";

class _MyFirestorePageState extends State<MyFirestorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: colleController,
              decoration: InputDecoration(
                hintText: 'for test',
              ),
            ),
            ElevatedButton(
              child: Text('set uid'),
              onPressed: () async {
                g_colle = colleController.text;
                // g_doc = docController.text;
                g_doc = uid;
              },
            ),
            TextField(
              controller: friendController,
              decoration: InputDecoration(
                hintText: 'add friend id',
              ),
            ),
            ElevatedButton(
              child: Text('set friendid'),
              onPressed: () async {
                friendid = friendController.text;
              },
            ),
            TextField(
              controller: getController,
              decoration: InputDecoration(
                hintText: 'select feild',
              ),
            ),
            ElevatedButton(
              child: Text('set feild'),
              onPressed: () async {
                print(await getProfileField(uid,getController.text));
              },
            ),
            ElevatedButton(
              child: Text('フレンド追加'),
              onPressed: () async {
                updateFriend("friend_uid", friendid);
              },
            ),
            ElevatedButton(
              child: Text('ドキュメント作成，追加'),
              onPressed: () async {
                // setUser();
                setFriend();
              },
            ),
            ElevatedButton(
              child: Text('ドキュメント削除'),
              onPressed: () async {
                deleteDoc();
              },
            ),
            ElevatedButton(
              child: Text('getFriends'),
              onPressed: () async {
                print(await (getFriends()));
              },
            ),
            ElevatedButton(
              child: Text('getProfile'),
              onPressed: () async {
                //getProfile();
              },
            ),
            ElevatedButton(
              child: Text('selectAll'),
              onPressed: () async {
                selectAll();
              },
            ),
            ElevatedButton(
              child: Text('selectWhere'),
              onPressed: () async {
                selectWhere();
              },
            ),
            ElevatedButton(
              child: Text('mode pro'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

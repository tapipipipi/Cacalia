import 'package:cacalia/CS/profile.dart';
import 'package:flutter/material.dart';
import 'CS/create.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// コレクション＝テーブル
// ドキュメント＝データ
// このページではdbの操作を行う。ボタンを押すとそれぞれの処理が実行される

class Store extends StatelessWidget {
  const Store({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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

class _MyFirestorePageState extends State<MyFirestorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: docController,
              decoration: InputDecoration(
                hintText: 'userID',
              ),
            ),
            TextField(
              controller: colleController,
              decoration: InputDecoration(
                hintText: 'コレクション',
              ),
            ),
            ElevatedButton(
              child: Text('set'),
              onPressed: () async {
                g_colle = colleController.text;
                g_doc = docController.text;
              },
            ),
            ElevatedButton(
              child: Text('ドキュメント作成，追加'),
              onPressed: () async {
                setDoc();
              },
            ),
            ElevatedButton(
              child: Text('ドキュメント削除'),
              onPressed: () async {
                deleteDoc();
              },
            ),
            ElevatedButton(
              child: Text('selectDoc'),
              onPressed: () async {
                selectDoc();
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

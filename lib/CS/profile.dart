import 'package:cacalia/store.dart';
import 'package:flutter/material.dart';
import './create.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// コレクション＝テーブル
// ドキュメント＝データ
// このページではdbの操作を行う。ボタンを押すとそれぞれの処理が実行される

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'edit profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: editProfilePage(),
    );
  }
}

class editProfilePage extends StatefulWidget {
  const editProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _editProfilePageState createState() => _editProfilePageState();
}

final nameController = TextEditingController();
final comeController = TextEditingController();
final eveController = TextEditingController();
final beController = TextEditingController();
final hobyController = TextEditingController();
final bgController = TextEditingController();


class _editProfilePageState extends State<editProfilePage> {
  // バリデーションチェックを一括で
  final formKey = GlobalKey<FormState>(); // GlobalKeyを発行
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
          children: <Widget>[
                 TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'name',
              ),
            ),
                        TextField(
              controller: comeController,
              decoration: InputDecoration(
                hintText: 'comment',
              ),
            ),            TextField(
              controller: eveController,
              decoration: InputDecoration(
                hintText: 'events',
              ),
            ),
                        TextField(
              controller: beController,
              decoration: InputDecoration(
                hintText: 'belong',
              ),
            ),            TextField(
              controller: hobyController,
              decoration: InputDecoration(
                hintText: 'hoby',
              ),
            ),            TextField(
              controller: bgController,
              decoration: InputDecoration(
                hintText: 'background',
              ),
            ),            ElevatedButton(
              child: Text('do'),
              onPressed: () async {
                // 脳筋実装でごめん 
                String name = nameController.text;
                String come = comeController.text;
                String eve = eveController.text;
                String belong = beController.text;
                String hoby = hobyController.text;
                String background = bgController.text;

                // key値はcreate.dartのprofileのmapの値参照
                updateDoc(profile.keys.elementAt(1), name); // name
                updateDoc(profile.keys.elementAt(4), come); // comment
                updateDoc(profile.keys.elementAt(5), eve);  // events
                updateDoc(profile.keys.elementAt(6), belong); // belong
                updateDoc(profile.keys.elementAt(9), hoby);   // hoby
                updateDoc(profile.keys.elementAt(10), background); // background
              },
            ),  
            ElevatedButton(
              child: Text('mode stor'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Store()),
                );
              },
            ),   
          ],
        ),
        )
        
      ),
    );
  }
}
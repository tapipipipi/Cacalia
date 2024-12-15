import 'package:cacalia/Auth/user_info_screen.dart';
import 'package:cacalia/CS/create.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signupScreen.dart';
/*
flutter foundation パッケージに用意されている変数で、
アプリケーションが Web 上で実行するようにコンパイルされているかどうかを調べるための変数です。
*/
import 'package:flutter/foundation.dart';
import 'package:cacalia/firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



// 認証系のメソッドをまとめたやつ( 2024/12/13:現在googleの認証は機能してません.理由は知らん)
class Authentication {
  // Firebase initialization
  static Future<FirebaseApp> initializeFirebase(
      {required BuildContext context}) async {
        FirebaseApp firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      await FirebaseAuth.instance.signOut();  // キャッシュユーザー強制ログアウト


    // ---------------なんか悪さしてる----------------------
    // User? user = FirebaseAuth.instance.currentUser;

    // // 自動ログイン.
    // if (user != null) {  //userがloginしていれば.
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => UserInfoScreen( //画面遷移 ログイン状態を保持しているならここでメインメニューに切り替えてもよい.
    //         user: user,
    //       ),
    //     ),
    //   );
    // }

    // ---------------なんか悪さしてる----------------------

    return firebaseApp;
    }

  // uidを返す関数
  String getuid (){
    /// FirebaseAuthインスタンスのcurrentUserプロパティを使う
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      return user.uid;
    }else {
      return "nouser";
    }
  }
  // GoogleSignIn
  // for web (KIWEb)
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) { // web版
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {  // mobile
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }

    return user;
  }
  
  // GoogleSignOut
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {  // mobileの場合
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  //ErrorSnackBar エラー時のメッセージを表示
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}

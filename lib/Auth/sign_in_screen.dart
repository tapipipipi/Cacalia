// import 'package:cacalia/Auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'google_sign_in_button.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});


  @override

  _SignInScreenState createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      //backgroundColor: CustomColors.firebaseNavy,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.only(

            left: 16.0,

            right: 16.0,

            bottom: 20.0,

          ),

          child: Column(

            mainAxisSize: MainAxisSize.max,

            children: [

              Row(),

              Expanded(

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Flexible(

                      flex: 1,

                      child: Image.asset(

                        'assets/firebase_logo.png',

                        height: 160,

                      ),

                    ),

                    SizedBox(height: 20),

                    Text(

                      'FlutterFire',

                      style: TextStyle(

                        //color: CustomColors.firebaseYellow,

                        fontSize: 40,

                      ),

                    ),

                    Text(

                      'Authentication',

                      style: TextStyle(

                        //color: CustomColors.firebaseOrange,

                        fontSize: 40,

                      ),

                    ),

                  ],

                ),

              ),

              FutureBuilder(

                future: Authentication.initializeFirebase( context : context),

                builder: (context, snapshot) {

                
                  if (snapshot.connectionState == ConnectionState.waiting) { 
                    return CircularProgressIndicator(); // データがまだ取得されていない場合のローディング表示
                  } else if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else {
                    // データが取得された場合
                    return GoogleSignInButton();
                  }

                  // return CircularProgressIndicator(

                  //   valueColor: AlwaysStoppedAnimation<Color>(

                  //     Colors.blue,

                  //   ),

                  // );

                },

              ),

            ],

          ),

        ),

      ),

    );

  }

}


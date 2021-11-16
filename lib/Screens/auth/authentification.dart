import 'dart:convert';
import 'dart:math';

import 'package:chip_in_flutter_version/Screens/auth/User.dart';
import 'package:chip_in_flutter_version/Screens/auth/appleAuth.dart';
import 'package:chip_in_flutter_version/Screens/auth/googleAuth.dart';
import 'package:chip_in_flutter_version/Services/hive.dart';
import 'package:chip_in_flutter_version/main.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'User.dart';



class Authentification extends StatefulWidget {
  const Authentification({Key? key}) : super(key: key);

  @override
  _Authentification createState() => _Authentification();
}

class _Authentification extends State<Authentification> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentification"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                GoogleAuth? googleAuth;
                googleAuth!.signInWithGoogle();
                SaveOnHiveBox(googleAuth.googleUser);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyBottomNavigationBar()));
              },
              child: Text("Google Sign In"),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                AppleAuth? appleAuth;
                appleAuth?.signInWithApple();
                SaveOnHiveBox(appleAuth?.appleCredential);   
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyBottomNavigationBar()));
              },
              child: Text("Apple Sign In"),
            ),
          ),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));
    });
  }

  Future<void> SaveOnHiveBox(var UserAuth) async {
    //сохранеие данных в кэш
    HiveService hiveService = HiveService();
    hiveService.addObjectOnBoxes(UserAuth, "UserProfile");
  }
  
}

import 'dart:convert';
import 'dart:math';

import 'package:chip_in_flutter_version/Screens/auth/User.dart';
import 'package:chip_in_flutter_version/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
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
      body: Container(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
            onPressed: () async {
              await signInWithGoogle();
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));
            },
            child: Text("Google Sign In"),
            ),
      ),
    );
  }
  
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      print("completed");
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));
      
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    
    );   
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    
  }
  
}

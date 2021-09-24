import 'dart:convert';
import 'dart:math';

import 'package:chip_in_flutter_version/Screens/auth/User.dart';
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
  GoogleSignInAccount? googleUser;
  AuthorizationCredentialAppleID? appleCredential;
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
                await signInWithGoogle();
                SaveOnHiveBox(googleUser);
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
                await signInWithApple();
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    SaveOnHiveBox(googleUser);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> SaveOnHiveBox(GoogleSignInAccount? GoogleUser) async {
    //сохранеие данных в кэш
    HiveService hiveService = HiveService();
    User_profile user = User_profile(GoogleUser!.id, GoogleUser.displayName,
        GoogleUser.email, GoogleUser.photoUrl);
    hiveService.addObjectOnBoxes(user, "GoogleUserProfile");
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}

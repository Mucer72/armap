import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      if(kDebugMode){
        debugPrint("User ID: ${userCredential.user?.uid}");
      }
      return userCredential;
    } catch (e) {
      if(kDebugMode){
        debugPrint(e.toString());
      }
      return null;
    }
  }
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
        return userCredential;
    }
    catch (e) {
      if(kDebugMode){
        debugPrint(e.toString());
      }
      return null;
    }
    }
  }
  String? checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


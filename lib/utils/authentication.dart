import 'package:decksplayer/decksplayer/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';




final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class Authentication{
  static UserSettings _userSettings = new UserSettings();

  static Future<FirebaseApp> initFirebase( {required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authSignedIn = prefs.getBool('auth') ?? false;
      FirebaseApp firebaseApp = await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null){
        _userSettings.setUserData(user);
      }
      return firebaseApp;
    }
   static Future<User?> singInWithGoogle() async {
     FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();


    if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
      );
      try{
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        user = userCredential.user;
        if(user != null){
          _userSettings.setUserData(user);
        }
      } on FirebaseAuthException catch (e){
        if(e.code == 'acount-exist-with-different-credential')
          print('The account already exists with a different credential.');
        else if(e.code == 'invalid-credential')
          print('Error occurred while accessing credentials. Try Again');
      } catch(e){
        print(e);
      }
    }
    return user;
  }

  static Future<String> singOut() async{
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);
    _userSettings.setEmptyValue();
    return 'User Signed Out';
  }

  static void singOutGoogle() async{
    await googleSignIn.signOut();
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth',false);
  }

  Future getUser() async{
    await Firebase.initializeApp();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authSignedIn = prefs.getBool('auth') ?? false;

    final User? user = _auth.currentUser;

    if(authSignedIn == true){
      if(user != null){
        _userSettings.setUserData(user);
      }
    }
  }

  static get getUserSettings {
    return _userSettings;
  }

}


class UserSettings{
  String? _uid;
  String? _name;
  String? _userEmail;
  String? _imageUrl;

  void setUserData(User user){
    _uid = user.uid;
    _name = user.displayName;
    _userEmail = user.email;
    _imageUrl = user.photoURL;
  }

  void setEmptyValue(){
    _uid = null;
    _name = null;
    _userEmail = null;
    _imageUrl = null;
  }

  String? get getUid{
    return _uid;
  }
  String? get getName{
    return _name;
  }

  String? get getUserEmail{
    return _userEmail;
  }

  String? get getImageUrl{
    return _imageUrl;
  }
}


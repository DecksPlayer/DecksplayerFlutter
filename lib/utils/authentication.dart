import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';




final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();




Future<User?> singInWithGoogle() async {
  await Firebase.initializeApp();
  User? user;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final UserSettings _userSettings = new UserSettings();


  if(googleSignInAccount != null){
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );

    try{
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
        if(e.code == 'acount-exist-with-different-credential')
          print('The account already exists with a different credential.');
        else if(e.code == 'invalid-credential')
          print('Error occurred while accessing credentials. Try Again');
    } catch(e){
      print(e);
    }

    if(user !=null){
      _userSettings.setUserData(user);
      SharedPreferences  prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
    }

    return user;
  }

  Future<String> singOut() async{
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);
    _userSettings.setEmptyValue();
    return 'User Signed Out';
  }

  void singOutGoogle() async{
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
}

class UserSettings{
  String? uid;
  String? name;
  String? userEmail;
  String? imageUrl;

  void setUserData(User user){
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;
  }

  void setEmptyValue(){
    uid = null;
    name = null;
    userEmail = null;
    imageUrl = null;
  }

  String? get getUid{
    return uid;
  }
  String? get getName{
    return name;
  }

  String? get getUserEmail{
    return userEmail;
  }

  String? get getImageUrl{
    return imageUrl;
  }
}
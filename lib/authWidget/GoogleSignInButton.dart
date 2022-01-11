import 'package:decksplayer/decksplayer/MainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decksplayer/utils/authentication.dart';

class GoogleButton extends StatefulWidget{
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton>{
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DecoratedBox(decoration:
      ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueGrey.shade700,width: 3)
        ),color: Colors.white
      ),
      child: OutlinedButton(style: OutlinedButton.styleFrom(
          primary: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color:Colors.blueGrey,width: 3 )
          ), elevation: 0
        ),onPressed: _pressAction,
        child: _isProcessing ? CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation(Colors.blueGrey),
        ) : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/google_logo.png"),
              height: 30.0,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Sign in with Google',
                  style: TextStyle(fontSize: 20,color:Colors.blueGrey),
                )
            ),
          ],
        ),
      ),
    );
  }

  _pressAction() async{
    setState(() {
      _isProcessing = true;
    });
    await singInWithGoogle().then((result){
      print(result);
      if(result != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DecksPlayer()));
      }
    }).catchError((error){
        print('Registration Error: $error');
      }
    );
    setState(() {
      _isProcessing = false;
    });
  }
}
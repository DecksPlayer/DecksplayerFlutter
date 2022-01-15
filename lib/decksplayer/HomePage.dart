import 'dart:html';

import 'package:decksplayer/authWidget/GoogleSignInButton.dart';
import 'package:decksplayer/utils/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
    home:new Scaffold(
      body: prepareChildren(),
      backgroundColor: Colors.blueGrey.shade800,
      bottomNavigationBar: new BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('decksplayer.com')
          ],
        ),
      ),
    ),
      debugShowCheckedModeBanner: false,
    );
  }

  Center prepareChildren(){
    return Center(
      child:getCard()
    );
  }

  Card getCard(){
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.min,
        children:<Widget> [
          Padding(padding: EdgeInsets.only(top: 16,bottom: 16),
              child: Image.asset(
                'assets/images/decksplayer-512.png'
                ,alignment: Alignment.center
                ,width: 125,height: 125,),
          ),
          Padding(padding: EdgeInsets.all(16),
            child:Text('Welcome To Decksplayer',style: new TextStyle(fontSize:30,color: Colors.blue),textAlign: TextAlign.center,),
          ),
          Padding(padding: EdgeInsets.all(16),child:FutureBuilder(
            future: Authentication.initFirebase(context:context),
            builder:(context,snapshot){
              if(snapshot.hasError){
                return Text('Error initializating firebase');
              }else if(snapshot.connectionState == ConnectionState.done){
                return GoogleButton();
              }
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent.shade200),
              );
            }

          )),
          Padding(padding: EdgeInsets.only(bottom: 16), child: Text(''),)
        ],
      ),
      color: Colors.blueGrey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
    );
  }

}
import 'package:decksplayer/utils/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainNavBar extends StatelessWidget{
  bool _singOut = false;

  @override
  Widget build(BuildContext context) {
    UserSettings _userSettings = Authentication.getUserSettings;
    // TODO: implement build
    return Drawer(
      child:Container(
        color: Colors.blueGrey.shade900 ,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_userSettings.getName!),
              accountEmail: Text(_userSettings.getUserEmail!),
              currentAccountPicture:new CircleAvatar(child:Image.network(_userSettings.getImageUrl!),radius: 60.0,),
              arrowColor: Colors.blueGrey.shade900,
            ),
            ListTile(title: Text('Log Out',style: TextStyle(color: Colors.white70,),
            )
            )
          ],
        ),
      )
    );
  }

  
}

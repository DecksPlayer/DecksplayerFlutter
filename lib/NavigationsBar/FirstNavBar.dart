import 'package:decksplayer/utils/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainNavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      backgroundColor: Colors.blueGrey.shade900,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(title: Text('Log Out',style: TextStyle(color: Colors.blueGrey.shade400),),
            onTap: ()=>{
                Navigator.of(context).pop()
            },
          )
        ],
      ),
    );
  }


}
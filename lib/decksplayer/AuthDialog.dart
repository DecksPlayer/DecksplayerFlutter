import 'package:decksplayer/authWidget/GoogleSignInButton.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget{
    @override
    _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog>{
  @override
  Widget build(BuildContext context){
    return Dialog(
       child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(16.0),
           child: Container(
             child: Column(
               children: [
                 Text('Welcome To Decksplayer'),
                 Center(child: GoogleButton(),)
               ],
             ),
           ),
         ),
       ),
    );
  }
}
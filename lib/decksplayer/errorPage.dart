import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class errorPage extends StatefulWidget{

  @override
  ErrorPageState createState() =>ErrorPageState();
}

class ErrorPageState extends State<errorPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text("Error",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
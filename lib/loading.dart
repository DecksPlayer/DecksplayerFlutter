import 'dart:html';

import 'package:flutter/material.dart';

class loadingFile extends StatefulWidget{
  @override
  LoadFile createState() => LoadFile();
}

class LoadFile extends State<loadingFile >{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
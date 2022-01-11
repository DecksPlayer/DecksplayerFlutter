import 'package:decksplayer/decksplayer/AuthDialog.dart';
import 'package:decksplayer/decksplayer/errorPage.dart';
import 'package:decksplayer/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'decksplayer/HomePage.dart';



void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HomePage());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    await getUserInfo();
    setState(() {});

  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}






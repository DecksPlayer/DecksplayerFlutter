import 'dart:math';
import 'dart:ui';

import 'package:decksplayer/decksplayer/errorPage.dart';
import 'package:decksplayer/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class DecksPlayer extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decksplayer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blueGrey
      ),
      home: MyHomePage(title: 'Decksplayer'),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
   String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLargeScreen = false;
  ListWidget listWidget = new ListWidget(0);

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    listWidget = ListWidget(100);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      appBar: AppBar(

        // Here we take the value from the MyHomePage object that wascolor created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title!),
        leading: Image.asset('assets/images/decksplayer-512.png',height: 18,width: 18,),
        automaticallyImplyLeading: true,
      ),
      body: OrientationBuilder(builder: (context,orientation){
        if(MediaQuery.of(context).size.width>600){
          isLargeScreen = true;
        }else {
          isLargeScreen = false;
        }
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child:Row(children: <Widget>[
                  Expanded(child: Text("PlayList",style: TextStyle(fontSize: 35,color: Colors.white70),textAlign: TextAlign.center ,),flex: 4,),
                  Expanded(child: buildFloatingSearchBar(),flex: 6,),
                  Expanded(child: Text(""))
                ]),flex: 1),
                Expanded(child: Row(
                  children: <Widget>[
                    Expanded(child: Text(""),flex: 2),
                    Expanded(child: ListWidget(100),flex: 12,),
                    Expanded(child: Text(""),flex: 2),
                  ],
                ),flex: 10,)
              ],
            )
        );
      }),

      backgroundColor: Colors.blueGrey[900],
    );


  }
  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      height: isPortrait&&isLargeScreen ? 50:40,
      scrollPadding:  EdgeInsets.only(top:isPortrait&&isLargeScreen ? 56:15, bottom: isPortrait&&isLargeScreen?56:25),
      margins: EdgeInsets.only(top: isPortrait&&isLargeScreen ? 20:10),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait&&isLargeScreen ? 1.0 : 0.0,
      openAxisAlignment: isPortrait&&isLargeScreen ? 1.0: 0.0,
      width: isPortrait&&isLargeScreen ? 150 : 300,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.

      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.music_note),
            onPressed: () {

            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return Center();
      },
    );
  }
}

class ListWidget extends StatefulWidget {
  final int count;

  ListWidget(
      this.count,
      );

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Random random = new Random(1);
    return Scrollbar(
        isAlwaysShown: true,
        controller: _firstController,
        child: ListView.builder(
          itemCount: widget.count,
          controller: _firstController,
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: InkWell(
                  onTap: () {
                    null;
                  },
                  child: Row(
                    children: <Widget>[
                      Image(image: Image.asset('assets/images/decksplayer-512.png',height: 18,width: 18,).image,height: 50,width: 50,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(position.toString(), style: TextStyle(fontSize: 22.0,color: Colors.white70)),
                      ),
                      Expanded(child:Column(
                        children: <Widget>[
                          Text("hola",style: TextStyle(fontSize: 22.0, color: Colors.white70),)
                          ,Row(children:<Widget>[
                            Expanded(child:LinearProgressIndicator(value: random.nextDouble()  ,semanticsValue: 'Linear progress indicator',color: Colors.teal[700],valueColor: new AlwaysStoppedAnimation(Colors.green[800])),)
                            ,Text("1:55",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,color: Colors.white70),)
                          ])
                        ],
                      ))
                    ],
                  ),
                ),
                color: Colors.blueGrey[700],
                shadowColor: Colors.blueGrey[900],
              ),
            );
          },
        )
    );
  }
}
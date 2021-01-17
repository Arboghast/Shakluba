import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Shakluba',
      home: Header(),
    );
  }
}

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Container()
    );
  }
}

import 'package:flutter/material.dart';
import 'custom_icons.dart';

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
            icon: Icon(CustomIcons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CustomIcons.bread),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Container()
    );
  }
}

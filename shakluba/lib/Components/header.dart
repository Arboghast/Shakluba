import 'package:flutter/material.dart';
import 'custom_icons.dart';
import 'dart:math';
import 'mainpage.dart';
import 'ingredients.dart';
import 'favorites.dart';
import 'search.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Shakluba',
      home: Header(),
    );
  }
}

class Header extends StatefulWidget {
  final PageController controller = PageController(initialPage: 1);

  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<Header> {
  int target = 2;
  int previous = 2;

  void tabAnimation(int target) {
    setState(() {
      widget.controller.animateToPage(target - 1, duration: new Duration(milliseconds: 500) , curve: Curves.easeOutSine);
      //widget.controller.jumpToPage(target-1);
      previous = target;
      target = target;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              IconButton(
                  icon: Icon(CustomIcons.fancysearch, color: Color.fromRGBO(169,255,178,1), size: 35),
                  padding:EdgeInsets.only(bottom:2),
                  onPressed: () => tabAnimation(1),
              ),
              IconButton(
                icon: Icon(CustomIcons.chefhat, color: Color.fromRGBO(169,255,178,1), size: 35),
                padding:EdgeInsets.only(bottom:2),
                onPressed: () => tabAnimation(2),
              ),
              IconButton(
                icon: Icon(CustomIcons.harvest, color: Color.fromRGBO(169,255,178,1), size: 35),
                padding:EdgeInsets.only(),
                onPressed: () => tabAnimation(3),
              ),
              IconButton(
                icon: Icon(CustomIcons.medal, color: Color.fromRGBO(169,255,178,1), size: 35),
                padding:EdgeInsets.only(),
                onPressed: () => tabAnimation(4),
              ),
          ],
        ),
        elevation: 1,
        backgroundColor: Color.fromRGBO(25,25,25,1),
      ),
      body: Stack(
        children: <Widget> [
          PageView(
            controller: widget.controller,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Search(),
              MainCard(),
              FoodLists(),
              Favorites(),
            ],
          ),
          ActiveTab(this.target,this.previous),
        ], 
      ),
      backgroundColor:Colors.white,
    );
  }
}

class ActiveTab extends StatelessWidget {
  final Alignment currLoc;
  final int duration;
  ActiveTab._(this.duration, this.currLoc);

  factory ActiveTab(int target, int previous){
    final List<double> normalized = [-0.805,-0.325,0.165,0.635];
    double distance = (target - previous).toDouble();
    distance = distance < 0 ? -1*distance : distance;
    int duration = ((800 * log(distance+1.25)) + 400).round();
    Alignment currLoc = new Alignment(normalized[target-1], -1);
    return ActiveTab._(duration, currLoc);
  }

  Widget build(BuildContext context){
    return AnimatedAlign(
        alignment: currLoc,
        child: Icon(CustomIcons.triangle, color: Color.fromRGBO(25,25,25,1), size: 20),
        curve: Curves.elasticOut,
        duration: Duration(milliseconds: duration),
    );
  }
}
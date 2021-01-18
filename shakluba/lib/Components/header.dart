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

class Header extends StatefulWidget {

  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<Header> {
  int target;

  void tabAnimation(int target) {
    setState(() => this.target = target);
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
        //backgroundColor: Colors.blue,
      ),
      body: ActiveTab(this.target), backgroundColor:Colors.white, 
    );
  }
}

class ActiveTab extends StatelessWidget {
  List<double> targets = [50,180,350,480];
  ActiveTab(int target)
  {
    print(target);
     AnimatedAlign(
        alignment: new Alignment(0, 50),
        child: Icon(CustomIcons.triangle, color: Color.fromRGBO(0,0,0,1), size: 20, ),
        curve: Curves.elasticOut,
        duration: Duration(milliseconds: 300),
    );
  }

  Widget build(BuildContext context){
    return AnimatedAlign(
        alignment: Alignment.topCenter,
        child: Icon(CustomIcons.triangle, color: Color.fromRGBO(0,0,0,1), size: 20, ),
        curve: Curves.elasticOut,
        duration: Duration(milliseconds: 300),
    );
  }
}
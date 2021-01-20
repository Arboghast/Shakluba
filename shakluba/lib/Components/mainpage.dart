import 'package:flutter/material.dart';
import 'custom_icons.dart';

class MainCard extends StatefulWidget{
  @override
  _MainCardState createState() => new _MainCardState();
}

class _MainCardState extends State<MainCard>{
  
 @override
  Widget build(BuildContext context){
    return Container(
      child: SliverAppBar(
        flexibleSpace: new Stack(
          children: <Widget>[
            Icon(CustomIcons.save),
            //ImageCard(),
            Icon(CustomIcons.heartfilled),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(CustomIcons.star),
                  Icon(CustomIcons.star),
                  Icon(CustomIcons.star),
                  Icon(CustomIcons.star),
                  Icon(CustomIcons.star),
                ],
              )   
            ),
          ],
        ),
      )
    );
  }
}

// class ImageCard extends StatelessWidget{
//   Image img;
//   double rating;
//   bool fav;

//   @override
//   Widget build(BuildContext context){
//     return ();
//   }
// }

class TextCard extends StatefulWidget
{
  List<String> ingredients;
  List<String> instructions;
  @override
  _TextCardState createState() => new _TextCardState();
}
class _TextCardState extends State<TextCard>{

  @override
  Widget build(BuildContext context){

  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_icons.dart';
import 'dart:math';

var MockCategories = [
  "Trending",
  "Meals",
  "Snacks",
  "Desserts",
  "Chinese",
  "Keto",
  "Indian",
  "Italian",
  "Healthy",
  "Russian",
  "Middle Eastern",
];

class Search extends StatefulWidget{

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>{
  ScrollController sc = ScrollController();

  @override
  initState(){
    super.initState();
    sc.addListener(_scrollListener);
  }
  

  _scrollListener(){
    if (sc.offset >= sc.position.maxScrollExtent && !sc.position.outOfRange) {
      setState(() {
        Random random = Random();
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        print("end");
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
      ),
      body: Categories(MockCategories, sc),
    );
  }
}

class SearchBar extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
      width: 500,
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(CustomIcons.simplesearch),
          border: OutlineInputBorder(),
          labelText: "Search for Recipes",
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget{
  final List<Widget> categories;
  final ScrollController sc;

  Categories._(this.categories, this.sc);

  factory Categories(List<String> list, ScrollController sc){
    List<Widget> x = [];
    for(int i = 0; i < list.length; i++){
      GridCard widget = GridCard('images/${i+1}.png', list[i]);
      x.add(widget);
    }
    return Categories._(x,sc);
  }

  @override
  Widget build(BuildContext context){
    return GridView.count(
      controller: sc,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: EdgeInsets.all(15),
      children: [
        ...categories
      ],
    );
  }
}

class GridCard extends StatelessWidget{
  final String img;
  final String name;

  GridCard(this.img, this.name);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.contain,
        ),
        color: Colors.red
      ),
      child: Center(child: Text(name, textAlign: TextAlign.center,)),
    );
  }
}
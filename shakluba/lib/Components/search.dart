
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'search_list.dart';
import 'static_recipe.dart';
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
  final ScrollController sc = ScrollController();
  final PageController pc = PageController();

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>{
  List<Widget> pages;
  int previous;
  int curr;

  @override
  initState(){
    super.initState();
    widget.sc.addListener(_scrollListener);
    pages = [Categories(MockCategories, widget.sc, _onSearch)];
    previous = -1;
  }
  

  _scrollListener(){
    if (widget.sc.offset >= widget.sc.position.maxScrollExtent && !widget.sc.position.outOfRange) {
      setState(() {
        Random random = Random();
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        MockCategories.add(MockCategories[random.nextInt(MockCategories.length-1)]);
        pages = [Categories(MockCategories, widget.sc, _onSearch)];
      });
    }
  }

  _onPress(String title){
    setState(() {
      pages.add(StaticRecipe('images/8.png', MockIngredients, MockInstructions, MockRecipes));
      widget.pc.nextPage(duration: Duration(microseconds: 100), curve: Curves.easeInOutBack);
      previous++;
    });
  }

  _onSearch(){
    setState(() {
      pages.add(RecipeList(MockCategories, _onPress));
      widget.pc.nextPage(duration: Duration(microseconds: 100), curve: Curves.easeInOutBack);
      previous++;
    });
    
  }

  _onSwipe(int page){ //left
    setState(() {
      if(page <= previous){
        pages.removeAt(page+1);
        previous--;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
      ),
      body: PageView(
        controller: widget.pc,
        scrollDirection: Axis.horizontal,
        onPageChanged: _onSwipe,
        children: [
          ...pages,
        ],
      )
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(CustomIcons.simplesearch),
                border: OutlineInputBorder(),
                labelText: "Search for Recipes",
              ),
            ),
          ),
          DropdownButton<String>(
            value: "One",
            icon: Icon(Icons.arrow_downward),
            iconSize: 32,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (var s)=> print("here $s"),
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      )
    );
  }
}

class Categories extends StatelessWidget{
  final List<Widget> categories;
  final ScrollController sc;

  Categories._(this.categories, this.sc);

  factory Categories(List<String> list, ScrollController sc, var cb){
    List<Widget> x = [];
    for(int i = 0; i < list.length; i++){
      GridCard widget = GridCard('images/${i+1}.png', list[i], cb);
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
  var onSearch;

  GridCard(this.img, this.name, this.onSearch);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onSearch,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.contain,
          ),
          color: Colors.red
        ),
        child: Center(child: Text(name, textAlign: TextAlign.center,)),
      ),
    );
  }
}
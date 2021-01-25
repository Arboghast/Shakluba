import 'package:flutter/material.dart';
import 'package:shakluba/Components/custom_icons.dart';
import 'package:shakluba/Components/mainpage.dart';
import 'package:shakluba/Components/static_recipe.dart';

var MockFavorites = [
  "Tofy Fried Rice",
  "Cauliflower donut",
  "Fried rice w/ tide",
  "Lemon pig feet",
  "cheese please",
  "Something I picked up from the trash",
];

class Favorites extends StatefulWidget{
  final PageController pc = PageController();

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorites>{
  StaticRecipe selectedRecipe;
  List<Widget> pages;

  @override
  void initState(){
    super.initState();
    pages = [RecipeList(MockFavorites, _unfavorite, _onPress)];
  }
  

  void _unfavorite(String title){
    setState(() {
      MockFavorites.removeWhere((element) => element == title);
      pages = [RecipeList(MockFavorites, _unfavorite, _onPress)]; //the Recipe List is no longer updated when setState is called because it lives in the state
    });
  }

  void _onPress(String title){ //use title as id?
    setState(() {
      pages.add(StaticRecipe('images/8.png', MockIngredients, MockInstructions, MockRecipes));
      widget.pc.nextPage(duration: Duration(microseconds: 100), curve: Curves.easeInOutBack);
    });
  }

  void _onReturn(int page){
    setState(() {
      if(page == 0){
        pages.removeAt(1);
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(CustomIcons.heartfilled),
            Text("Favorites"),
          ],
        )
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: widget.pc,
        onPageChanged: _onReturn,
        children: [
          ...pages,
        ],
      )
    );
  }
}

class RecipeList extends StatelessWidget{
  final List<Widget> favorites;

  RecipeList._(this.favorites);

  factory RecipeList(List<String> favs, var callback, var onPress){
    List<Widget> x = [];
    for(int i = 0; i < favs.length; i++){
      var widget = RecipeCard(favs[i], 'images/${i+1}.png', callback, onPress);
      x.add(widget);
    }
    return RecipeList._(x);
  }

  @override
  Widget build(BuildContext context){
    return ListView(
      children: [
        ...favorites,
      ],
    );
  }
}

class RecipeCard extends StatelessWidget{
  final String title;
  final String img;
  var callback;
  var onPress;

  RecipeCard(this.title, this.img, this.callback, this.onPress);

  _unfav(){
    callback(title);
    print("hit");
  }

  _recip(){
    onPress(title);
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: _recip,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.fitWidth,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title),
            IconButton(
              icon: Icon(CustomIcons.heartfilled),
              onPressed: _unfav,
            )
          ],
        )
      ),
    );
  }
}
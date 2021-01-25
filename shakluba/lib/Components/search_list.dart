import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'custom_icons.dart';

class RecipeList extends StatelessWidget{
  final List<Widget> favorites;

  RecipeList._(this.favorites);

  factory RecipeList(List<String> favs, var callback){
    List<Widget> x = [];
    for(int i = 0; i < favs.length; i++){
      var widget = RecipeCard(favs[i], 'images/${i+1}.png', callback);
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
  var cb;

  RecipeCard(this.title, this.img, this.cb);

  _togFav(){
    print("liked");
  }

  _togTile(){
    print("hit");
  }

  _openRecipe(DismissDirection direction){
    if(DismissDirection.endToStart == direction){
      cb(title);
    }
    print(direction);
  }

  @override
  Widget build(BuildContext context){
    return ExpansionTile(
      title: GestureDetector(
        onTap: _togTile,
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
                icon: Icon(CustomIcons.heartempty),
                onPressed: _togFav,
              )
            ],
          )
        ),
      ),
      children: [
        Dismissible(
          onDismissed: _openRecipe,
          key: ValueKey("ok"),
          child: Container(
            color: Colors.blue,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("essential"),
                    Text("50 minutes"),
                  ],
                ),
                Row(
                  children: [
                    Text("optional"),
                    Text("cook time"),
                  ],
                ),
                Row(
                  children: [
                    Text("calories"),
                    Text("servings"),
                  ],
                ),
                Row(
                  children: [
                    Text("20 fat"),
                    Text("30 carbs"),
                    Text("12 protein"),
                  ],
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}
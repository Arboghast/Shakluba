import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'custom_icons.dart';
import 'dart:math';

const MockIngredients = [
  "2 cups uncooked instant rice ",
  "2 tablespoons vegetable oil, divided ",
  "14-ounce package reduced-fat firm tofu, drained and cut into (1/2-inch) cubes ",
  "2 large eggs, lightly beaten ",
  "1 cup (1/2-inch-thick) slices green onions ",
  "1 cup frozen peas and carrots, thawed ",
  "4 garlic cloves, minced ",
  "1 teaspoon minced peeled fresh ginger ",
  "2 tablespoons sake (rice wine) ",
  "3 tablespoons low-sodium soy sauce ",
  "1 tablespoon hoisin sauce ",
  "½ teaspoon dark sesame oil ",
  "Thinly sliced green onions (optional) "
];

const MockInstructions = [
  "Insert the eggs (whole) into the green onion ",
  "Lubricate your paintbrush with some vegetable oil ",
  "Throw tofu against the wall to check for ripeness ",
  "throw all the ingredients away because we both know you can't cook, just order a pizza. "
];

const MockRecipes = [
  "chicken fried rice",
  "lemon ade",
  "fried chicken"
];

class MainCard extends StatefulWidget{
  @override
  _MainCardState createState() => new _MainCardState();
}

class _MainCardState extends State<MainCard>{
  PanelController _filterController = PanelController();
  
 @override
  Widget build(BuildContext context){
    return Scaffold(
        floatingActionButton: FilterButton(_filterController),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        body: SlidingUpPanel(
          isDraggable: false,
          controller: _filterController,
          backdropEnabled: true,
          renderPanelSheet: false,
          margin: EdgeInsets.symmetric(horizontal: 20),
          collapsed: Container(child: Text("Currently collapsed"), color: Color.fromRGBO(13, 13, 13, 0.5)),      //Gradient should go here
          panel: Container(child: Text("The filters go here"), color: Color.fromRGBO(13, 13, 13, 0.0)),
          body: CustomScrollView(
            slivers: <Widget>[ 
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                expandedHeight: 500.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                    background: ImageCard('images/8.png', 4.6, true),
                ),
              ),
              RecipeCard(),
            ],
          )
         ),
      );
  }
}

class FilterButton extends StatelessWidget {
  final PanelController fc;

  FilterButton(this.fc);

  _filterToggle(){
    if(fc.isPanelOpen) {
      fc.close();
    } else {
      fc.open();
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
        width: 64.0,
        height: 64.0,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(CustomIcons.filter),
          onPressed: _filterToggle,
        )
    );
  }
}

class ImageCard extends StatelessWidget{
  final String img;
  final double rating;
  final bool fav;
  IconData favorite;
  ImageCard(this.img, this.rating, this.fav){
    this.favorite =  this.fav ? CustomIcons.heartfilled : CustomIcons.heartempty;
  }

  @override
  Widget build(BuildContext context){
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(this.img, fit: BoxFit.cover),
          Icon(CustomIcons.save),
          Icon(favorite),
          Row(
            children: <Widget>[
              Icon(CustomIcons.star),
              Icon(CustomIcons.star),
              Icon(CustomIcons.star),
              Icon(CustomIcons.star),
              Icon(CustomIcons.star),
            ],
          ),
        ],
      );
  }
}

class RecipeCard extends StatelessWidget{
  List<Widget> ingredients = [];
  List<Widget> instructions = [];
  List<Widget> recipes = [];

  RecipeCard(){
    Random random = new Random();
    for(int i = 0; i < MockIngredients.length; i++){
      bool checked = random.nextInt(100) > 50;
      ingredients.add( Ingredient(checked, MockIngredients[i]));
    }
    for(int i = 0; i < MockInstructions.length; i++){
      instructions.add( Text(MockInstructions[i]));
    }
    for(int i = 0; i < MockRecipes.length; i++){
      recipes.add( AltRecipe('images/${i+1}.png', MockRecipes[i]));
    }
  }


  @override
  Widget build(BuildContext context){
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ...ingredients,
          ...instructions,
          ...recipes,
        ],
      )
    );
  }
}

class Ingredient extends StatelessWidget{
  IconData checkbox;
  String name;
  Ingredient(bool isChecked, this.name){
    checkbox = isChecked ? CustomIcons.uncheckedbox : CustomIcons.checkedbox;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: [
          Icon(checkbox),
          Text(name),
        ],
      )
    );
  }
}

class AltRecipe extends StatelessWidget{
  String img;
  String name;
  
  AltRecipe(this.img, this.name);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        Image.asset(img),
        Text(name),
      ],
    );
  }
}
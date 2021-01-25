import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
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

const MockImages = [
  "images/1.png",
  "images/2.png",
  "images/3.png",
  "images/4.png",
  "images/5.png",
  "images/6.png",
  "images/7.png",
  "images/8.png",
  "images/9.png",
];

class MainCard extends StatefulWidget{
  // Stateless members go here

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard>{
  //stateful members go here
  List<Widget> recipes = [];
  int previousPage = 0;
  PageController pageController = PageController(initialPage: 0);
  static PanelController filterController = PanelController();

  @override
  initState(){
    super.initState();
    recipes.add(SwipeCard(filterController, MockImages[0], MockIngredients, MockInstructions, MockRecipes));
    recipes.add(SwipeCard(filterController, MockImages[1], MockIngredients, MockInstructions, MockRecipes));
  }

  _updateList(int page){
    if(previousPage >= 0 && previousPage >= page){ //left swipe
      setState(() {

      });
    } else { //right swipe
      setState(() {
        previousPage = page;
        if(recipes.length <= page+2){
          recipes.add(SwipeCard(filterController, MockImages[page+1], MockIngredients, MockInstructions, MockRecipes));
        }
      });
    }
    
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
        floatingActionButton: FilterButton(filterController),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        body: PageView(
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: _updateList,
          controller: pageController,
          children: [
            ...recipes,
          ],
        )
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

class SwipeCard extends StatelessWidget{
  final PanelController fc;
  final String img;
  final List<String> ing;
  final List<String> inst;
  final List<String> alt;
  SwipeCard(this.fc, this.img, this.ing, this.inst, this.alt);

  @override
  Widget build(BuildContext context){
    return SlidingUpPanel(
      isDraggable: false,
      controller: fc,
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
              collapseMode: CollapseMode.parallax,
                background: ImageCard(img, 4.6, true),
            ),
          ),
          RecipeCard(ing,inst,alt),   //not dynamic as of yet
        ],
      )
    );
  }
}

class ImageCard extends StatelessWidget{
  final String img;
  final double rating;
  final bool fav;
  final IconData favorite;
  ImageCard(this.img, this.rating, this.fav):
          favorite =  fav ? CustomIcons.heartfilled : CustomIcons.heartempty;

  @override
  Widget build(BuildContext context){
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(img, fit: BoxFit.cover),
          Icon(CustomIcons.save),
          Icon(favorite),
          SmoothStarRating(
            starCount: 5,
            isReadOnly: true,
            rating: this.rating,
            allowHalfRating: true,
          ),
        ],
      );
  }
}

class RecipeCard extends StatelessWidget{
  final List<Widget> ingredients;
  final List<Widget> instructions;
  final List<Widget> recipes;

  //https://stackoverflow.com/questions/42864913/how-do-i-initialize-a-final-class-property-in-a-constructor
  RecipeCard._(this.ingredients, this.instructions, this.recipes);

  factory RecipeCard(List<String> ing, List<String> inst, List<String> alt){
    List<Widget> x = [];
    List<Widget> y = [];
    List<Widget> z = [];
    Random random = new Random();
    for(int i = 0; i < ing.length; i++){
      bool checked = random.nextInt(100) > 50;
      x.add( Ingredient(checked, ing[i]));
    }
    for(int i = 0; i < inst.length; i++){
      y.add( Text(inst[i]));
    }
    for(int i = 0; i < alt.length; i++){
      z.add( AltRecipe('images/${i+1}.png', alt[i]));
    }
    return RecipeCard._(x,y,z);
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
  final IconData checkbox;
  final String name;
  Ingredient(bool isChecked, this.name):
          checkbox = isChecked ? CustomIcons.uncheckedbox : CustomIcons.checkedbox;

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
  final String img;
  final String name;
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

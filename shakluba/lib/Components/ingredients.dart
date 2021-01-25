import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'custom_icons.dart';

const MockIngredients = [
  "1 pound sweet Italian sausage ",
  "¾ pound lean ground beef ",
  "½ cup minced onion ",
  "2 cloves garlic, crushed",
  "1 (28 ounce) can crushed tomatoes",
  "2 (6 ounce) cans tomato paste",
  "2 (6.5 ounce) cans canned tomato sauce",
  "½ cup water ",
  "2 tablespoons white sugar",
  "1 ½ teaspoons dried basil leaves",
  "½ teaspoon fennel seeds",
  "1 teaspoon Italian seasoning",
  "1 ½ teaspoons salt, divided, or to taste",
  "¼ teaspoon ground black pepper",
  "4 tablespoons chopped fresh parsley",
  "12 lasagna noodles",
  "16 ounces ricotta cheese",
  "1 egg",
  "¾ pound mozzarella cheese, sliced ",
  "¾ cup grated Parmesan cheese",
  "1 pound sweet Italian sausage ",
  "¾ pound lean ground beef ",
  "½ cup minced onion ",
];

class FoodLists extends StatefulWidget{
  final PageController pc = PageController();
  final PanelController fc = PanelController();

  @override
  _FoodListsState createState() => _FoodListsState();
}

class _FoodListsState extends State<FoodLists>{
  bool toggle = true;

  _pageChanged(int page){
    setState(() {
        toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: ActionButton(widget.pc, toggle, widget.fc),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: SearchBar(toggle),
        backgroundColor: Color.fromRGBO(1, 1, 1, 0.0),
      ),
      body: SlidingUpPanel(
          isDraggable: false,
          controller: widget.fc,
          backdropEnabled: true,
          renderPanelSheet: false,
          margin: EdgeInsets.symmetric(horizontal: 20),
          collapsed: Container(child: Text("Currently collapsed"), color: Color.fromRGBO(13, 13, 13, 0.5)),      //Make this completly invisible
          panel: Container(child: Text("The filters go here"), color: Color.fromRGBO(13, 13, 13, 0.0)),
          body: PageView(
            onPageChanged: _pageChanged,
            pageSnapping: true,
            controller: widget.pc,
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Ingredients(MockIngredients),
              Blacklist(MockIngredients.where((element) => !element.contains("p")).toList()),
            ],
          ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget{
  final PageController pc;
  final PanelController fc;
  final bool toggle;

  ActionButton(this.pc, this.toggle, this.fc);

  _toggleFilter(){
    if(fc.isPanelOpen) {
      fc.close();
    } else {
      fc.open();
    }
  }

  @override
  Widget build(BuildContext context){ 
    if(toggle) {
      return Container(
        width: 64.0,
        height: 64.0,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(CustomIcons.camera),
          onPressed: ()=> print("camera"),
        )
      );
    } else {
      return Container(
        width: 64.0,
        height: 64.0,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(CustomIcons.filter),
          onPressed: _toggleFilter,
        )
      );
    }
  }
}

class SearchBar extends StatelessWidget{
  final String type;

  SearchBar._(this.type);

  factory SearchBar(bool toggle){
    var type = toggle ? "ingredients" : "exclusions";
    return SearchBar._(type);
  }

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
          labelText: "search your $type",
        ),
      ),
    );
  }
}

class Ingredients extends StatelessWidget{
  final List<Widget> ingredients;

  Ingredients._(this.ingredients);

  factory Ingredients(List<String> ingredients){
    List<Widget> widgets = []; 
    for(int i = 0; i < ingredients.length; i++){
      Dismissible widget = Dismissible(key: UniqueKey(), child: Text(ingredients[i]));
      widgets.add(widget);
    }
    return Ingredients._(widgets);
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        AddBar(true),
        ListWheelScrollView(
          itemExtent: 42,
          useMagnifier: true,
          magnification: 1.5,
          children: <Widget>[
            ...ingredients,
          ],
        ),
      ],
    );
  }
}

class AddBar extends StatelessWidget{
  final String type;

  AddBar._(this.type);

  factory AddBar(bool toggle){
    var type = toggle ? "ingredients" : "exclusions";
    return AddBar._(type);
  }

  @override
  Widget build(BuildContext context){
    return Positioned(
      top: 625,
      left: 450,
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
        width: 500,
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(CustomIcons.simplesearch),
            border: OutlineInputBorder(),
            labelText: "add $type",
          ),
        ),
      )
    );
  }
}

class Blacklist extends StatelessWidget{
  final List<Widget> blacklist;

  Blacklist._(this.blacklist);

  factory Blacklist(List<String> exclusions){
    List<Widget> widgets = [];
    for(int i = MockIngredients.length-1 ; i >= 0 ; i--){
      Dismissible widget = Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        child: Text(MockIngredients[i]),
        );
      widgets.add(widget);
    }
    return Blacklist._(widgets);
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        AddBar(false),
        ListWheelScrollView(
          itemExtent: 42,
          useMagnifier: true,
          magnification: 1.5,
          children: <Widget>[
            ...blacklist,
          ],
        ),
        Substitutes(),
      ],
    );
  }
}

class Substitutes extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Positioned(
      top: 525,
      left: 1285,
      child: Container(
        width: 44.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize: 30,
          icon: Icon(CustomIcons.swap),
          onPressed: ()=>{
            showDialog(
              context: context,
              builder: (_) => PopUp(),
            )
          }
        ),
      )
    );
  }
}

class PopUp extends StatelessWidget{

  _add(){
    print("hit");
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text("we'll substitute"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuantRow("Sugar", 1),
          Text("With:"),
          QuantRow("Black Beans", 2),
          QuantRow("Maga Beans", 3)
        ],
      ),
      actions: [
        GestureDetector(
          onTap: _add,
          child: Container(
            child: Row(
              children: [
                Text("Add ingredients"),
                Icon(CustomIcons.pluscircle),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class QuantRow extends StatelessWidget{
  final int n;
  final String ing;

  QuantRow(this.ing, this.n);

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Container(
          child: Text("$n"),
        ),
        Container(
          child: Text("$ing"),
        )
      ],
    );
  }
}
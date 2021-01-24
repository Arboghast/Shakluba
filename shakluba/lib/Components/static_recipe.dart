import 'package:flutter/material.dart';
import 'mainpage.dart';

class StaticRecipe extends StatelessWidget{
  final String img;
  final List<String> ing;
  final List<String> inst;
  final List<String> alt;
  StaticRecipe(this.img, this.ing, this.inst, this.alt);

  @override
  Widget build(BuildContext context){
    return CustomScrollView(
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
        RecipeCard(ing,inst,alt), 
      ],
    );
  }
}
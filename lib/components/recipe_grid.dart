import 'package:flutter/material.dart';
import 'package:praktikum_5/components/item_card_recipe.dart';
import 'package:praktikum_5/models/recipe_model.dart';
import 'package:praktikum_5/screens/recipe_detail_screen.dart';
import 'package:praktikum_5/services/api_services.dart';

class RecipeGrid extends StatefulWidget {
  const RecipeGrid({Key? key}) : super(key: key);

  @override
  _RecipeGridState createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  late Future<List<RecipeModel>> _futureRecipes;

  @override
  void initState() {
    super.initState();
    _futureRecipes = ApiServices.getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _futureRecipes, builder: RecipeGridView);
  }
}

Widget RecipeGridView(
  BuildContext context,
  AsyncSnapshot<List<RecipeModel>> snapshot,
) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return SliverToBoxAdapter(child: CircularProgressIndicator());
  } else if (snapshot.hasError) {
    return SliverToBoxAdapter(child: Text('Error: ${snapshot.error}'));
  } else if (!snapshot.hasData) {
    return SliverToBoxAdapter(child: Text('No data'));
  } else {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return ItemCardRecipe(
          recipe: snapshot.data![index],
          onTap: (RecipeModel recipe) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(recipe: recipe),
              ),
            );
          },
        );
      }, childCount: snapshot.data!.length),
    );
  }
}

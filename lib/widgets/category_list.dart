import 'package:cooking_papa/models/mealDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mealDetails.dart';
import '../providers/Recipe.dart';
import 'meal_item.dart';

class CategoryList extends StatelessWidget {
  List<MealDetails> displayedMeals;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        displayedMeals = Provider.of<Recipe>(context).displayedMeals;
        return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          image: displayedMeals[index].image,
          // duration: displayedMeals[index].duration,
          // affordability: displayedMeals[index].affordability,
          // complexity: displayedMeals[index].complexity,
        );
      },
      itemCount: Provider.of<Recipe>(context).displayedMeals.length,
    );
  }
}

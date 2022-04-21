import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

// FavoritesScreen is stateless class not contain any state
// this class is display all the favorite recipe that the user like
class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            image: favoriteMeals[index].image,
            // duration: favoriteMeals[index].duration,
            // affordability: favoriteMeals[index].affordability,
            // complexity: favoriteMeals[index].complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}

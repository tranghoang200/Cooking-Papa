import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Recipe.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

/**
 * CategoryMealsScreen is a statefull class which contain state that 
 * change when the app run
 * State:
 * availableMeals: list of Meal that is the database
 * categoryTitle: the title of the category that the user choose
 * displayedMeal: the current meal that user choose
 */

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  CategoryMealsScreen();

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals = <Meal>[];
  var _loadedInitData = false;
  var _isLoading = false;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() {
    if (!_loadedInitData) {
      setState(() {
        _isLoading = true;
      });
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];

      Provider.of<Recipe>(context).getMealsListData().then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
      displayedMeals = Provider.of<Recipe>(context).displayedMeals;
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: displayedMeals[index].id,
                  title: displayedMeals[index].title,
                  image: displayedMeals[index].image,
                  // duration: displayedMeals[index].duration,
                  // affordability: displayedMeals[index].affordability,
                  // complexity: displayedMeals[index].complexity,
                );
              },
              itemCount: displayedMeals.length,
            ),
    );
  }
}

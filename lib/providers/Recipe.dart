import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/meal.dart';
import '../models/mealDetails.dart';

class Recipe extends ChangeNotifier {
  String _ingredients = '';
  String _category = '';
  String _selectedRecipe = '';
  String _recipeId = '';
  List<Meal> displayedMeals = [];

  MealDetails selectedMeal;

  // String title = '';
  // String image = '';
  // int servings = 1;
  // int readyInMinutes = 0;
  // String instructions = '';
  // List<String> extendedIngredients = [];
  // String summary = '';

  String get ingredients => _ingredients;

  String get category => _category;

  String get selectedRecipe => _selectedRecipe;

  void setIngredients(ingredients) {
    _ingredients = ingredients;
    notifyListeners();
  }

  void setCategory(category) {
    _category = category;
    notifyListeners();
  }

  void setSelectedRecipe(selectedRecipe) {
    _selectedRecipe = selectedRecipe;
    notifyListeners();
  }

  Future<void> getMealsListData() async {
    var url = Uri.https('api.spoonacular.com', '/recipes/complexSearch', {
      'apiKey': 'a1010fb55d144683a37a103da734ca3c',
      "cuisine": _category.toLowerCase(),
      // "includeIngredients": ingredients.toLowerCase()
    });

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      var data = await jsonResponse["results"];
      List<Meal> list = <Meal>[];
      for (var i = 0; i < data.length; i++) {
        list.add(Meal(
            id: data[i]["id"].toString(),
            title: data[i]["title"],
            image: data[i]["image"]));
      }
      displayedMeals = list;
      notifyListeners();
    }
  }

  Future<void> getMealDetail(recipeId) async {
    var url = Uri.https(
        'api.spoonacular.com',
        '/recipes/' + recipeId + '/information',
        {'apiKey': 'a1010fb55d144683a37a103da734ca3c'});
    print(url);

// Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      String title = data['title'];
      String image = data['image'];
      int servings = data['servings'];
      int readyInMinutes = data['readyInMinutes'];
      String instructions = data['instructions'];
      String summary = data['summary'];
      List<String> list = [];
      List ingredientsList = data['extendedIngredients'];
      for (var i = 0; i < ingredientsList.length; i++) {
        list.add(ingredientsList[i]['amount'].toString() +
            " " +
            ingredientsList[i]['unit'] +
            " " +
            ingredientsList[i]['name']);
      }

      List<String> extendedIngredients = list;

      selectedMeal = MealDetails(
          title: title,
          image: image,
          id: int.parse(recipeId),
          servings: servings,
          readyInMinutes: readyInMinutes,
          instructions: instructions,
          extendedIngredients: extendedIngredients,
          summary: summary);
      print(selectedMeal);
    }
    notifyListeners();
  }
}

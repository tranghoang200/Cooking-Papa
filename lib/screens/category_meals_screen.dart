import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:provider/provider.dart';
import '../providers/Recipe.dart';
import '../widgets/category_list.dart';

/**
 * CategoryMealsScreen is a statefull class which contain state that change when the app run
 * Protential State:
 * categoryTitle: Title of the category
 * displayedMeals: List of Meals to display in the screen
 * _loadedInitData: load initial data
 * _isLoading: loading the data
 */
class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  var _loadedInitData = false;
  var _isLoading = false;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      setState(() {
        _isLoading = true;
      });
      Provider.of<Recipe>(context).getMealsListData().then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : CategoryList(),
    );
  }
}

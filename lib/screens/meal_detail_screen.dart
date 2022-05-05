import 'package:cooking_papa/providers/Recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

/**
 * MealDetailScreen is a statefull class which contain state that change when the app run
 * Protential State:
 * selectedMeal: The meal that user selected
 * _loadedInitData: load initial data
 * _isLoading: loading the data
 */
class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  var _loadedInitData = false;
  var _isLoading = false;
  var selectedMeal;

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Future<void> didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      // still under develop
      // image = routeArgs['image'];
      String recipeId = routeArgs['id'];
      print(recipeId);
      setState(() {
        _isLoading = true;
      });
      Provider.of<Recipe>(context).getMealDetail(recipeId).then((value) => {
            setState(() {
              _isLoading = false;
            })
          });
      print(selectedMeal);
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // still under develop
    // final mealId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: _isLoading
            ? Text('')
            : Text('${Provider.of<Recipe>(context).selectedMeal.title}'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      Provider.of<Recipe>(context).selectedMeal.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  buildSectionTitle(context, 'Ingredients'),
                  buildContainer(
                    ListView.builder(
                      itemBuilder: (ctx, index) {
                        selectedMeal =
                            Provider.of<Recipe>(context).selectedMeal;
                        return Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Text(
                                  selectedMeal.extendedIngredients[index])),
                        );
                      },
                      itemCount: Provider.of<Recipe>(context)
                          .selectedMeal
                          .extendedIngredients
                          .length,
                    ),
                  ),
                  // still under develop
                  buildSectionTitle(context, 'Steps'),
                  buildContainer(
                    ListView.builder(
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${(index + 1)}'),
                            ),
                            title: Text(
                              Provider.of<Recipe>(context)
                                  .selectedMeal
                                  .instructions[index],
                            ),
                          ),
                          Divider()
                        ],
                      ),
                      itemCount: Provider.of<Recipe>(context)
                          .selectedMeal
                          .instructions
                          .length,
                    ),
                  ),
                ],
              ),
            ),
      // still under develop
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     widget.isFavorite(mealId) ? Icons.star : Icons.star_border,
      //   ),
      //   onPressed: () => widget.toggleFavorite(mealId),
      // ),
    );
  }
}

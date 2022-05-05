import 'package:cooking_papa/providers/Recipe.dart';
import 'package:provider/provider.dart';

import './categories_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

/**
 * IngredientScreen is a statefull class which contain state that change when the app run
 * State:
 * image: display image of the recipe
 * ingredients: list of ingredients
 */

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key key}) : super(key: key);
  static const routeName = '/ingredient_screen';

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  String image;
  List<String> ingredients;
  var _loadedInitData = false;
  String ingredientsList;

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
      image = routeArgs['image'];
      String input2 = Provider.of<Recipe>(context).ingredients;
      ingredients = input2.split(',');
      // setState(() {
      //   ingredients = input2.split(',');
      // });
      ingredientsList = input2;
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  removeItem(int index) {
    ingredients.removeAt(index);
    setState(() {});
    print(ingredients);
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ingredient"),
        ),
        body: Column(children: [
          Container(
              padding: EdgeInsets.all(20),
              child: new Image.memory(base64Decode(image))),
          Container(
            // padding: EdgeInsets.all(20),
            child: Text(
              'Ingredient',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            // itemCount: ingredients.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                // height: 50,
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    // margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Color.fromARGB(255, 187, 187, 187)),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration:
                          InputDecoration(focusedBorder: InputBorder.none),
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        // _authData['email'] = value;
                      },
                      initialValue: ingredients[index],
                    ),
                  )),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => removeItem(index),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              CategoriesScreen.routeName,
              arguments: {
                'ingredients': ingredientsList,
              },
            ),
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 20),
            ),
          )
        ]));
  }
}

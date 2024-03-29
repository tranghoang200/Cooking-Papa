import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

// CategoriesScreen is stateless class not contain any state
// this class is display all the categories from the database
// for user to choose when limit the recipe
class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: GridView(
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES
              .map(
                (catData) => CategoryItem(
                  catData.id,
                  catData.title,
                  catData.color,
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        ));
  }
}

import 'package:flutter/foundation.dart';

class MealDetails {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final String instructions;
  final List<String> extendedIngredients;
  final String summary;

  const MealDetails({
    @required this.title,
    @required this.image,
    @required this.id,
    @required this.servings,
    @required this.readyInMinutes,
    @required this.instructions,
    @required this.extendedIngredients,
    @required this.summary,
  });
}

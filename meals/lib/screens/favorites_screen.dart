import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;

  const FavoritesScreen(
      {Key? key, required this.favoriteMeals, required this.toggleFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('Empty'),
      );
    } else {
      return Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              meal: favoriteMeals[index],
              toggleFavorite: toggleFavorite,
            );
          },
          itemCount: favoriteMeals.length,
        ),
      );
    }
  }
}

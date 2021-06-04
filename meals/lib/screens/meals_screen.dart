import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  final List<Meal> availableMeals;
  final Function toggleFavorite;

  const MealsScreen(
      {Key? key, required this.availableMeals, required this.toggleFavorite})
      : super(key: key);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late Map<String, String> mealCategory;
  late List<Meal> meals;
  bool loadedData = false;

  @override
  void didChangeDependencies() {
    if (!loadedData) {
      mealCategory =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      meals = widget.availableMeals
          .where((meal) => meal.categories.contains(mealCategory['id']))
          .toList();
      loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealCategory['title']!),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              meal: meals[index],
              toggleFavorite: widget.toggleFavorite,
            );
          },
          itemCount: meals.length,
        ),
      ),
    );
  }
}

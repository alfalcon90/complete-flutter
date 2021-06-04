import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (filterData['gluten']! && !meal.isGlutenFree) {
          return false;
        } else if (filterData['lactose']! && !meal.isLactoseFree) {
          return false;
        } else if (filterData['vegan']! && !meal.isVegan) {
          return false;
        } else if (filterData['vegetarian']! && !meal.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final int existingIndex =
        favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed'),
            ),
      ),
      routes: {
        '/': (context) => TabScreen(
            favoriteMeals: favoriteMeals, toggleFavorite: toggleFavorite),
        MealsScreen.routeName: (context) => MealsScreen(
            availableMeals: availableMeals, toggleFavorite: toggleFavorite),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavorite: toggleFavorite, isMealFavorite: isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(filterData: filters, setFilters: setFilters),
      },
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => CategoriesScreen()),
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => CategoriesScreen()),
    );
  }
}

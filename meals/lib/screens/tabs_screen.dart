import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_screen.dart';
import 'package:meals/widgets/drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;

  const TabScreen(
      {Key? key, required this.favoriteMeals, required this.toggleFavorite})
      : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favorites',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoritesScreen(
                favoriteMeals: widget.favoriteMeals,
                toggleFavorite: widget.toggleFavorite)
          ],
        ),
        drawer: Drawer(
          child: SideDrawer(),
        ),
      ),
      length: 2,
    );
  }
}

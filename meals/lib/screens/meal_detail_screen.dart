import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'dart:core';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetailScreen(
      {Key? key, required this.toggleFavorite, required this.isMealFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
              isMealFavorite(meal.id) ? Icons.favorite : Icons.favorite_border),
          onPressed: () => toggleFavorite(meal.id)),
      body: ListView(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: meal.ingredients
                      .map(
                        (ingredient) => Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ingredient,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Text(
                    'Steps',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: meal.steps
                      .mapIndexed(
                        (step, index) => Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('#${index + 1} $step'),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

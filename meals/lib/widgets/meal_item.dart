import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final Function toggleFavorite;

  const MealItem({Key? key, required this.meal, required this.toggleFavorite})
      : super(key: key);

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Hard:
        return 'Hard';
      case Complexity.Challenging:
        return 'Challenging';
      default:
        return 'Simple';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxuriuos';
      default:
        return 'Affordable';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: meal)
        .then((value) => {
              if (value != null) {toggleFavorite(value)}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => selectMeal(context),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 16,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 8),
                      Text('${meal.duration} mins')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.bolt_outlined),
                      SizedBox(width: 8),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.monetization_on_outlined),
                      SizedBox(width: 8),
                      Text(affordabilityText)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

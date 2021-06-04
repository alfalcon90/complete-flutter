import 'package:flutter/material.dart';
import 'package:meals/screens/filters_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(24),
          alignment: Alignment.centerLeft,
          child: Text(
            'Cooking Up',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        ListTile(
          leading: Icon(
            Icons.restaurant,
            size: 24,
          ),
          title: Text(
            'Meals',
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.filter_alt_outlined,
            size: 24,
          ),
          title: Text(
            'Filters',
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          },
        )
      ],
    );
  }
}

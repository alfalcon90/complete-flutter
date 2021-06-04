import 'package:flutter/material.dart';
import 'package:meals/widgets/drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function setFilters;
  final Map<String, bool> filterData;

  const FiltersScreen(
      {Key? key, required this.setFilters, required this.filterData})
      : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  void dispose() {
    widget.setFilters(widget.filterData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: Drawer(
        child: SideDrawer(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              SwitchListTile(
                value: widget.filterData['gluten']!,
                onChanged: (newValue) {
                  setState(() {
                    widget.filterData['gluten'] = newValue;
                  });
                },
                title: Text('Gluten-Free'),
                subtitle: Text('Only include gluten-free meals.'),
              ),
              SwitchListTile(
                value: widget.filterData['vegetarian']!,
                onChanged: (newValue) {
                  setState(() {
                    widget.filterData['vegetarian'] = newValue;
                  });
                },
                title: Text('Vegetarian'),
                subtitle: Text('Only include vegetarian meals.'),
              ),
              SwitchListTile(
                value: widget.filterData['vegan']!,
                onChanged: (newValue) {
                  setState(() {
                    widget.filterData['vegan'] = newValue;
                  });
                },
                title: Text('Vegan'),
                subtitle: Text('Only include vegan meals.'),
              ),
              SwitchListTile(
                value: widget.filterData['lactose']!,
                onChanged: (newValue) {
                  setState(() {
                    widget.filterData['lactose'] = newValue;
                  });
                },
                title: Text('Lactose-free'),
                subtitle: Text('Only include lactose-free meals.'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

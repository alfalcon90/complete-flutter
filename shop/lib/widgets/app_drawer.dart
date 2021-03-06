import 'package:app_name/helpers/custom_route.dart';
import 'package:app_name/screens/orders_screen.dart';
import 'package:app_name/screens/overview_screen.dart';
import 'package:app_name/screens/products_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello there'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () => Navigator.of(context).pushReplacement(
                  CustomRoute(builder: (context) => OverviewScreen()))),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}

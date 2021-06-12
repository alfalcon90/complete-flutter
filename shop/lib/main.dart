import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:app_name/screens/product_details_screen.dart';
import 'package:app_name/screens/overview_screen.dart';
import 'package:app_name/screens/cart_screen.dart';
import 'package:app_name/screens/orders_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
      home: OverviewScreen(),
      routes: {
        ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        OrdersScreen.routeName: (context) => OrdersScreen(),
      },
    );
  }
}

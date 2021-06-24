import 'package:app_name/helpers/custom_route.dart';
import 'package:app_name/providers/auth.dart';
import 'package:app_name/screens/auth_screen.dart';
import 'package:app_name/screens/edit_product_screen.dart';
import 'package:app_name/screens/products_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:app_name/screens/product_details_screen.dart';
import 'package:app_name/screens/overview_screen.dart';
import 'package:app_name/screens/cart_screen.dart';
import 'package:app_name/screens/orders_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          })),
      home: auth.isSignedIn ? OverviewScreen() : AuthScreen(),
      routes: {
        ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        OrdersScreen.routeName: (context) => OrdersScreen(),
        ProductsScreen.routeName: (context) => ProductsScreen(),
        EditProductScreen.routeName: (context) => EditProductScreen(),
      },
    );
  }
}

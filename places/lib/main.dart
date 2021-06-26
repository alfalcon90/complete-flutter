import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:places/screens/list_screen.dart';
import 'package:places/screens/map_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListScreen(),
      routes: {
        AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        MapScreen.routeName: (ctx) => MapScreen(),
      },
    );
  }
}

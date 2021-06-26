import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/providers/places.dart';
import 'package:places/screens/add_place_screen.dart';

class ListScreen extends HookWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(placesProvider.notifier).init();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Consumer(
          child: Center(
            child: Text('No places added yet, start adding some!'),
          ),
          builder: (ctx, watch, child) {
            final places = watch(placesProvider);
            return places.length <= 0
                ? child!
                : ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(places[i].image),
                      ),
                      title: Text(places[i].title),
                      subtitle: Text(places[i].location.address),
                      onTap: () {},
                    ),
                  );
          },
        ),
      ),
    );
  }
}

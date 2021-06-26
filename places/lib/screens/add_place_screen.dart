import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/providers/places.dart';
import 'package:places/widgets/image_input.dart';
import 'package:places/widgets/location_input.dart';

class AddPlaceScreen extends HookWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();

    File? pickedImage;
    PlaceLocation? pickedLocation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                  ),
                  SizedBox(height: 12),
                  ImageInput((File img) => pickedImage = img),
                  SizedBox(height: 12),
                  LocationInput((double lat, double lon) => pickedLocation =
                      PlaceLocation(latitude: lat, longitude: lon)),
                ],
              ),
            )),
            ElevatedButton.icon(
              onPressed: () {
                if (pickedImage == null ||
                    titleController.text.isEmpty ||
                    pickedLocation == null) {
                  return;
                }

                context.read(placesProvider.notifier).add(
                      DateTime.now().toString(),
                      titleController.text,
                      pickedImage!,
                      pickedLocation!,
                    );
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.add),
              label: Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}

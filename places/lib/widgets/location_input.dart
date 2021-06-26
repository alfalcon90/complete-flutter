import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places/providers/places.dart';
import 'package:places/screens/map_screen.dart';

class LocationInput extends HookWidget {
  const LocationInput(this.onSaveLocation, {Key? key}) : super(key: key);
  final Function onSaveLocation;

  @override
  Widget build(BuildContext context) {
    final previewImageUrl = useState<String?>(null);

    Future<void> getCurrentLocation() async {
      Location location = new Location();
      LocationData locationData = await location.getLocation();

      previewImageUrl.value = LocationHelper.generateImageUrl(
          locationData.latitude!, locationData.longitude!);

      onSaveLocation(locationData.latitude, locationData.longitude);
    }

    Future<void> selectOnMap() async {
      final selectedLocation = await Navigator.of(context).push<LatLng>(
          MaterialPageRoute(
              builder: (ctx) => MapScreen(), fullscreenDialog: true));

      if (selectedLocation == null) {
        return;
      }

      onSaveLocation(selectedLocation.latitude, selectedLocation.longitude);
      previewImageUrl.value = LocationHelper.generateImageUrl(
          selectedLocation.latitude, selectedLocation.longitude);
    }

    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: previewImageUrl.value == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl.value!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: getCurrentLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on map'),
              onPressed: selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}

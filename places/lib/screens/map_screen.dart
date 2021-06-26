import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends HookWidget {
  const MapScreen({Key? key}) : super(key: key);

  static const routeName = '/map';

  @override
  Widget build(BuildContext context) {
    final pickedLocation = useState<LatLng?>(null);

    void selectLocation(LatLng position) {
      pickedLocation.value = position;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Select location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (pickedLocation.value == null) {
                return;
              }
              Navigator.of(context).pop(pickedLocation.value);
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.4746,
        ),
        onTap: selectLocation,
        markers: pickedLocation.value == null
            ? {}
            : {
                Marker(
                    markerId: MarkerId('m1'), position: pickedLocation.value!)
              },
      ),
    );
  }
}

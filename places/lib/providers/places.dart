import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'dart:convert';

class PlaceLocation {
  PlaceLocation(
      {required this.latitude, required this.longitude, String? address}) {
    if (address == null) {
      LocationHelper.getAddress(this.latitude, this.longitude)
          .then((value) => this.address = value);
    } else {
      this.address = address;
    }
  }

  final double latitude;
  final double longitude;
  late String address;
}

class Place {
  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, ver) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lon REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    Database db = await database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> get(String table) async {
    Database db = await database();
    return db.query(table);
  }
}

const API_KEY = '';

class LocationHelper {
  static String generateImageUrl(double lat, double lon) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lon&zoom=13&size=600x300&maptype=roadmap&&markers=color:red%7C$lat,$lon&key=$API_KEY';
  }

  static Future<String> getAddress(double lat, double lon) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$API_KEY');

    Response res = await get(url);
    return json.decode(res.body)['results'][0]['formatted_address'];
  }
}

class Places extends StateNotifier<List<Place>> {
  Places(List<Place> state) : super(state);

  void add(String id, String title, File image, PlaceLocation location) {
    state = [
      ...state,
      Place(id: id, title: title, image: image, location: location)
    ];
    DBHelper.insert('user_places', {
      'id': id,
      'title': title,
      'image': image.path,
      'lat': location.latitude,
      'lon': location.longitude,
      'address': location.address
    });
  }

  void init() async {
    final data = await DBHelper.get('user_places');
    state = [
      ...data
          .map((place) => Place(
              id: place['id'].toString(),
              title: place['title'].toString(),
              image: File(
                place['image'].toString(),
              ),
              location: PlaceLocation(
                latitude: double.parse(place['lat'].toString()),
                longitude: double.parse(place['lon'].toString()),
                address: place['address'].toString(),
              )))
          .toList()
    ];
  }
}

final placesProvider =
    StateNotifierProvider<Places, List<Place>>((_) => Places([]));

import 'package:flutter/cupertino.dart';
import 'package:greatPlace/helpers/location_helper.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File img, PlaceLocation placeLocation) async {
    final String address = await LocationHelper.getPlaceAddress(
        placeLocation.latitude, placeLocation.longitude);

    final updatedLoc = PlaceLocation(
      latitude: placeLocation.latitude,
      longitude: placeLocation.longitude,
      addess: address,
    );

    final place = Place(
      id: DateTime.now().toString(),
      image: img,
      title: title,
      location: updatedLoc,
    );
    _items.add(place);
    notifyListeners();

    DBHelper.insert(DBHelper.TABLE_NAME, {
      DBHelper.KEY_ID: place.id,
      DBHelper.KEY_TITLE: place.title,
      DBHelper.KEY_IMAGE: place.image.path,
      DBHelper.KEY_LAT: place.location.latitude,
      DBHelper.KEY_LNG: place.location.longitude,
      DBHelper.KEY_address: place.location.addess,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBHelper.getData(DBHelper.TABLE_NAME);

    _items = datalist
        .map((item) => Place(
              id: item[DBHelper.KEY_ID],
              title: item[DBHelper.KEY_TITLE],
              image: File(item[DBHelper.KEY_IMAGE]),
              location: PlaceLocation(
                latitude: item[DBHelper.KEY_LAT],
                longitude: item[DBHelper.KEY_LNG],
                addess: item[DBHelper.KEY_address],
              ),
            ))
        .toList();
    notifyListeners();
  }

  Place findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}

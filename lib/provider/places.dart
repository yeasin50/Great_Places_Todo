import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File img) {
    final place = Place(
        id: DateTime.now().toString(),
        image: img,
        title: title,
        location: null);
    _items.add(place);
    notifyListeners();

    DBHelper.insert(DBHelper.TABLE_NAME, {
      DBHelper.KEY_ID: place.id,
      DBHelper.KEY_TITLE: place.title,
      DBHelper.KEY_IMAGE: place.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBHelper.getData(DBHelper.TABLE_NAME);

    _items = datalist
        .map((item) => Place(
              id: item[DBHelper.KEY_ID],
              title: item[DBHelper.KEY_TITLE],
              image: File(item[DBHelper.KEY_IMAGE]),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String addess;

  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.addess,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}

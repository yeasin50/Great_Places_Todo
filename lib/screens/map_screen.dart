import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final initialLocation;
  bool isSelecting;

  MapScreen({
    //FIXME:: dont know why it is showing errors
    this.initialLocation =
        const PlaceLocation(latitude: 23.8103, longitude: 90.4125),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

//TODO::: need to update the sdk
class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLoc;

  void _selectedLocation(LatLng position) {
    setState(() {
      _pickedLoc = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLoc == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLoc);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectedLocation : null,
        markers: (_pickedLoc == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('selectedPosition'),
                  position: _pickedLoc ??
                      LatLng(widget.initialLocation.latitude,
                          widget.initialLocation.longitude),
                ),
              },
      ),
    );
  }
}

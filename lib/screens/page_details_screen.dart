import 'package:flutter/material.dart';
import 'package:greatPlace/screens/map_screen.dart';
import 'package:provider/provider.dart';
import '../provider/places.dart';

class PageDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details';
  const PageDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<Places>(context, listen: false).findByID(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.addess,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: Text("View On Map"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MapScreen(
                  initialLocation: selectedPlace.location,
                  isSelecting: true,
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}

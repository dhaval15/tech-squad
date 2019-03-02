import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:gplacespicker/gplacespicker.dart';
import 'package:relay/relay.dart';
import './nav.dart';

enum SelectionUpdate { a }

class SelectionStation extends Station<SelectionUpdate> {}

class SelectionState
    extends ProviderState<Selection, SelectionStation, SelectionUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    await selectMapA(context);
                  },
                  child: Text('Source'),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Destination'),
                ),
                SizedBox(height: 12),
                OutlineButton(
                  onPressed: _toNav,
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toNav() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Nav()));
  }
}

class Selection extends ProviderWidget<SelectionStation> {
  SelectionState createState() => SelectionState();

  @override
  SelectionStation createStation() {
    return SelectionStation();
  }
}

/*Future<LatLong> selectMap(context) async {
  Location location = Location();
  var current = await location.getLocation();
  LatLong loc = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LocationPickerPage(
            initialLocation: LatLong(current.latitude, current.latitude),
            inititialZoom: 9,
            okButtonText: 'Select',
            titleText: 'Select Source Location',
          )));
  return loc;
}*/

Future selectMapA(context) async {
  Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyDTfMJ4wkmGJ8JubIge0l3lQWzmEabJLbo',
      mode: Mode.overlay,
      // Mode.fullscreen
      language: "en",
      components: [new Component(Component.country, "en")]);
}

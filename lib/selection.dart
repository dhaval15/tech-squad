import 'package:flutter/material.dart';
import 'package:relay/relay.dart';
import './nav.dart';

enum SelectionUpdate { sourceUpdate, destUpdate }

class SelectionStation extends Station<SelectionUpdate> {
  String source = 'A';
  String dest = 'B';
}

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Source :',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    RelayBuilder(
                      station: station,
                      observers: [SelectionUpdate.sourceUpdate],
                      builder: (context, station) => DropdownButton(
                            onChanged: (v) {
                              station.source = v;
                              station.relay(SelectionUpdate.sourceUpdate);
                            },
                            value: station.source,
                            items: ['A', 'B', 'C', 'D', 'E']
                                .map((t) => DropdownMenuItem(
                                      child: Text('Block $t'),
                                      value: t,
                                    ))
                                .toList(),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Dest :',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    RelayBuilder(
                      station: station,
                      observers: [SelectionUpdate.destUpdate],
                      builder: (context, station) => DropdownButton(
                            onChanged: (v) {
                              station.dest = v;
                              station.relay(SelectionUpdate.destUpdate);
                            },
                            value: station.dest,
                            items: ['A', 'B', 'C', 'D', 'E']
                                .map((t) => DropdownMenuItem(
                                      child: Text('Block $t'),
                                      value: t,
                                    ))
                                .toList(),
                          ),
                    ),
                  ],
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

/*Future selectMapA(context) async {
  Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyDTfMJ4wkmGJ8JubIge0l3lQWzmEabJLbo',
      mode: Mode.overlay,
      // Mode.fullscreen
      language: "en",
      components: [new Component(Component.country, "en")]);
}*/

import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
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
                GestureDetector(
                  onTap: () {
                    var _mapView = MapView();
                    _mapView.show(MapOptions(
                      title: 'Select Source Destination',
                      mapViewType: MapViewType.normal,
                      showMyLocationButton: true,
                      showUserLocation: true,
                    ));
                  },
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Source'),
                  ),
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

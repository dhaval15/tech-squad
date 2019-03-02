import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:route_finder/home.dart';
import 'package:relay/relay.dart';

void main() {
  MapView.setApiKey("<your_api_key>");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Route Finder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

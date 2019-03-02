import 'package:flutter/material.dart';
import 'package:relay/relay.dart';

enum NavUpdate { a }

class NavStation extends Station<NavUpdate> {}

class NavState extends ProviderState<Nav, NavStation, NavUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Available Transports'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Dest(data: 'Source : Block A'),
                      SizedBox(height: 12),
                      Dest(data: 'Destination : Block Z'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.directions_bus,
                          size: 48,
                        ),
                      ),
                    ),
                    Card(
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.directions_bike,
                        size: 48,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _to() {}
}

class Nav extends ProviderWidget<NavStation> {
  @override
  NavStation createStation() => NavStation();

  NavState createState() => NavState();
}

class Dest extends StatelessWidget {
  final String data;

  const Dest({this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}

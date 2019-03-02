import 'package:flutter/material.dart';
import 'package:relay/relay.dart';
import 'package:route_finder/add_bus.dart';
import './selection.dart';

enum HomeUpdate { a }

class HomeStation extends Station<HomeUpdate> {}

class HomeState extends ProviderState<Home, HomeStation, HomeUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Route'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Add'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBus()));
        },
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome To Route Finder',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20),
                OutlineButton(
                  onPressed: _toSelection,
                  child: Text('Enter Your Location'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toSelection() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Selection()));
  }
}

class Home extends ProviderWidget<HomeStation> {
  HomeState createState() => HomeState();

  @override
  HomeStation createStation() {
    return HomeStation();
  }
}

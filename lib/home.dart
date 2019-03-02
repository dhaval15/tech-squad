import 'package:flutter/material.dart';
import 'package:relay/relay.dart';

enum HomeUpdate { a }

class HomeStation extends Station<HomeUpdate> {}

class HomeState extends ProviderState<Home, HomeStation, HomeUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find'),
      ),
    );
  }
}

class Home extends ProviderWidget<HomeStation> {
  final HomeStation station = HomeStation();

  HomeState createState() => HomeState();

  @override
  HomeStation createStation() {
    return HomeStation();
  }
}

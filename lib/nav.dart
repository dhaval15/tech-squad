import 'package:flutter/material.dart';
import 'package:relay/relay.dart';

enum NavUpdate { a }

class NavStation extends Station<NavUpdate> {}

class NavState extends ProviderState<Nav, NavStation, NavUpdate>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Available Transports'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Buses', icon: Icon(Icons.directions_bus)),
              Tab(text: 'Bikes', icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: TabBarView(
              children: [
                ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    Bus bus = Bus(
                      arrivalTime: DateTime.now(),
                      departureTime: DateTime.now().add(Duration(minutes: 27)),
                      busNo: '${index * index % 9}',
                      vacantSeats: index,
                    );
                    return Card(
                      child: ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.directions_bus),
                            Text(bus.busNo),
                          ],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${bus.arrival} - ${bus.departure} PM',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${bus.waiting.inMinutes}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        subtitle: Text('Vacant Seats : $index'),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Number of available Bikes'),
                  subtitle: Text('12'),
                ),
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

class Plate extends StatelessWidget {
  final IconData icon;
  final String title;

  const Plate({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 48),
            SizedBox(width: 16),
            Text(title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}

class Bus {
  final String busNo;
  final DateTime arrivalTime;
  final DateTime departureTime;
  final int vacantSeats;

  Bus({this.busNo, this.arrivalTime, this.departureTime, this.vacantSeats});

  String get arrival => '${arrivalTime.hour}:${arrivalTime.minute}';

  String get departure => '${arrivalTime.hour}:${arrivalTime.minute}';

  Duration get waiting => Duration(
      milliseconds: arrivalTime.millisecondsSinceEpoch -
          departureTime.millisecondsSinceEpoch);
}

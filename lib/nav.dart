import 'package:flutter/material.dart';
import 'package:relay/relay.dart';
import 'package:firebase_database/firebase_database.dart';

enum NavUpdate { a }

class NavStation extends Station<NavUpdate> {}

class NavState extends ProviderState<Nav, NavStation, NavUpdate>
    with SingleTickerProviderStateMixin {
  List<Bus> buses = [];
  Future<DataSnapshot> _bikeFuture;

  @override
  void initState() {
    super.initState();
    _bikeFuture = FirebaseDatabase.instance.reference().child('bikes').once();
    FirebaseDatabase.instance.reference().child('buses').onValue.listen((e) {
      buses.add(Bus.fromJson(e.snapshot.value));
      setState(() {});
    });
  }

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
                    //Bus bus = buses[index];
                    Bus bus = Bus(
                        vacantSeats: index * index % 3,
                        aTime: TimeOfDay(hour: 3, minute: 43),
                        rTime: TimeOfDay(hour: 4, minute: 2),
                        busNo: 'A${index * 2}');
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
                              '${bus.arrival} - ${bus.reaching} PM',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${bus.waiting}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        subtitle: Text('Vacant Seats : $index'),
                      ),
                    );
                  },
                ),
                FutureBuilder<DataSnapshot>(
                  future: _bikeFuture,
                  builder: (context, snapshot) => ListTile(
                        title: Text('Number of available Bikes'),
                        subtitle: Text(snapshot.hasData
                            ? snapshot.data.value.toString()
                            : '0'),
                      ),
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
  final TimeOfDay aTime;
  final TimeOfDay rTime;
  final int vacantSeats;

  Bus({this.busNo, this.vacantSeats, this.aTime, this.rTime});

  Map<String, dynamic> toJson() => {
        'a-time-h ': aTime.hour,
        'a-time-m': aTime.minute,
        'r-time-h': rTime.hour,
        'r-time-m': rTime.minute,
        'bus_no': busNo,
        'vacant': vacantSeats,
      };

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        aTime: TimeOfDay(hour: json['a-time-h'], minute: json['a-time-m']),
        rTime: TimeOfDay(hour: json['r-time-h'], minute: json['r-time-m']),
        vacantSeats: json['vacant'],
        busNo: json['bus_no'],
      );

  String get arrival => '${aTime.hour}:${aTime.minute}';

  String get reaching => '${rTime.hour}:${rTime.minute}';

  String get waiting {
    int hd = rTime.hour - aTime.hour;
    int md = rTime.minute - aTime.minute;
    if (md < 0) {
      hd--;
      md = -md;
    }
    if (hd == 0) return '$md Minutes';
    return '$hd Hours And $md Minutes';
  }
}

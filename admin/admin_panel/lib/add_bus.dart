import 'package:flutter/material.dart';
import 'package:relay/relay.dart';
import 'package:firebase_database/firebase_database.dart';

enum AddBusUpdate { change }

class AddBusStation extends Station<AddBusUpdate> {
  String busNo;
  String motionSensorId;
  int totalSeats;

  void update() {
    FirebaseDatabase.instance.reference().child('buses').push().set(Bus(
          busNo: busNo,
          totalSeats: totalSeats,
          motionSensorId: motionSensorId,
        ).toJson());
  }
}

class AddBusState extends ProviderState<AddBus, AddBusStation, AddBusUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bus'),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    station.busNo = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Bus No',
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    station.motionSensorId = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Motion Sensor Id',
                  ),
                ),
                TextField(
                  onChanged: (String text) {
                    station.totalSeats = int.parse(text);
                  },
                  decoration: InputDecoration(
                    labelText: 'Total Seates',
                  ),
                  keyboardType: TextInputType.number,
                ),
                OutlineButton(
                  child: Text('Submit'),
                  onPressed: () {
                    station.update();
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class AddBus extends ProviderWidget<AddBusStation> {
  @override
  AddBusStation createStation() => AddBusStation();

  AddBusState createState() => AddBusState();
}

class Bus {
  final String busNo;
  final int totalSeats;
  final String motionSensorId;

  Bus({this.busNo, this.totalSeats, this.motionSensorId});

  factory Bus.fromJson(Map<String, dynamic> doc) => Bus(
        busNo: doc['busNo'],
        motionSensorId: doc['motionSensorId'],
        totalSeats: doc['totalSeats'],
      );

  Map<String, dynamic> toJson() => {
        'busNo': busNo,
        'motionSensorId': motionSensorId,
        'totalSeats': totalSeats,
      };
}

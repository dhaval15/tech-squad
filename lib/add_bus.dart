import 'package:flutter/material.dart';
import 'package:relay/relay.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:route_finder/nav.dart';

enum AddBusUpdate { change }

class AddBusStation extends Station<AddBusUpdate> {
  String busNo;
  TimeOfDay aTime;
  TimeOfDay rTime;
  int vacantSeats;

  void update() {
    FirebaseDatabase.instance.reference().child('buses').push().set(Bus(
          busNo: busNo,
          aTime: aTime,
          rTime: rTime,
          vacantSeats: vacantSeats,
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
                OutlineButton(
                  child: Text('Arrival Time'),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      station.aTime =
                          TimeOfDay(hour: date.hour, minute: date.minute);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                OutlineButton(
                  child: Text('Reaching Time'),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      station.rTime =
                          TimeOfDay(hour: date.hour, minute: date.minute);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Vacant Seats',
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

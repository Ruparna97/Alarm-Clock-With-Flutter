import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  String _time = "";
  var alarmList = [];
  var week = DateFormat('EEEE').format(DateTime.now());
  @override
  void initState() {
    alarmList.add('21:03');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff000046), Color(0xff1CB5E0)])),
      child: Column(children: <Widget>[
        Expanded(
            child: SizedBox(
          height: 100.0,
          child: ListView.builder(
              padding: EdgeInsets.only(top: 30),
              scrollDirection: Axis.vertical,
              itemCount: alarmList.length,
              itemBuilder: (BuildContext context, int index) {
                final alarmTime = alarmList[index];
                final weekday = week;
                return Dismissible(
                  key: Key(alarmTime),
                  onDismissed: (direction) {
                    setState(() {
                      alarmList.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("alarm at $alarmTime dismissed")));
                  },
                  background: Container(color: Colors.blue),
                  child: ListTile(
                      title: Text(
                    '$weekday $alarmTime',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
                );
              }),
        )),
        IconButton(
          icon: Icon(Icons.alarm_add),
          tooltip: 'Add Alarm',
          iconSize: 50,
          color: Colors.white,
          onPressed: () {
            DatePicker.showTimePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true, onConfirm: (time) {
              print('confirm $time');
              _time = '${time.hour}:${time.minute}';
              print(_time);
              setState(() {
                alarmList.add(_time);
              });
            }, currentTime: DateTime.now(), locale: LocaleType.en);
            setState(() {});
          },
        ),
        Text(
          'Swipe To dismiss alarm',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:analog_clock/analog_clock.dart';

class Clock extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Clock> {
  String _dateString;
  String _timeString;

  @override
  void initState() {
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(hours: 1), (Timer t) => _getDate());
    super.initState();
    print(DateFormat('EEEE').format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff000046), Color(0xff1CB5E0)])),
        child: AnalogClock(
          hourHandColor: Colors.white,
          minuteHandColor: Colors.white,
          secondHandColor: Colors.white10,
          numberColor: Colors.white,
          showDigitalClock: true,
          digitalClockColor: Colors.white,
        ));
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    setState(() {
      _timeString = formattedTime;
    });
  }

  void _getDate() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDate(now);
    setState(() {
      _dateString = formattedTime;
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat.yMMMMd('en_US').format(dateTime);
  }
}

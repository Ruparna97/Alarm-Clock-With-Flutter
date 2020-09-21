import 'package:flutter/material.dart';
import 'stopwatch.dart';
import 'alarm.dart';
import 'clock.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Clock(),
    Alarm(),
    StopWatch(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Alarm Clock"),
        backgroundColor: Color.fromRGBO(15, 66, 98, 0.9),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Clock'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text(' Set Alarm'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.timer), title: Text('Stop Watch'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

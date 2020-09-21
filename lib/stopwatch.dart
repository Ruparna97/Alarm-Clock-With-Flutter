import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatch extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<StopWatch> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.setPresetSecondTime(0);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff000046), Color(0xff1CB5E0)])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// Display stop watch time
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Display every minute.
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.minuteTime,
              initialData: _stopWatchTimer.minuteTime.value,
              builder: (context, snap) {
                final value = snap.data;
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'minute',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Helvetica',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),

          /// Display every second.
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.secondTime,
              initialData: _stopWatchTimer.secondTime.value,
              builder: (context, snap) {
                final value = snap.data;
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'second',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Helvetica',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.all(8),
            child: StreamBuilder<List<StopWatchRecord>>(
              stream: _stopWatchTimer.records,
              initialData: _stopWatchTimer.records.value,
              builder: (context, snap) {
                final value = snap.data;
                if (value.isEmpty) {
                  return Container();
                }
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut);
                });

                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final data = value[index];
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${index + 1} ${data.displayTime}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        )
                      ],
                    );
                  },
                  itemCount: value.length,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Color(0xff203A43),
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },
                          child: const Text(
                            'Start',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Color(0xff203A43),
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Color(0xff203A43),
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                          },
                          child: const Text(
                            'Stop',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Color(0xff203A43),
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                          },
                          child: const Text(
                            'Lap',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

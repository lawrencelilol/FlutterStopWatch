import 'package:flutter/material.dart';
import 'dart:async';

// MAIN: Running our app here
void main() {
  runApp(MyApp());
}

// MY_APP: A widget that sets up the barebones app
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MyHomePage(title: 'Flutter Stopwatch'),
        debugShowCheckedModeBanner: false);
  }
}

// MY_HOME_PAGE: A widget that creates a homepage for the app
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// MY_HOME_PAGE_STATE: A widget that does the hard work of building out the details of MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  Stopwatch _stopWatch = new Stopwatch();

  String _elapsed = "00:00.000";

  int total = 0;
  int minutes = 0;
  int seconds = 0;
  int milli = 0;
  Timer? timer;
  static const duration = const Duration(milliseconds: 69);

  void _updateClock() {
    setState(() {
      total = _stopWatch.elapsedMilliseconds;
      if (total == 0) {
        _elapsed = "00:00.000";
      } else {
        minutes = total ~/ 60000;
        seconds = (total - (minutes * 60000)) ~/ 1000;
        milli = total - (minutes * 60000) - (seconds * 1000);
        _elapsed = _elapsed = "$minutes".padLeft(2, '0') +
        ":" +
        "$seconds".padLeft(2, '0') +
        "." +
        "$milli".padLeft(3, '0');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        _updateClock();
      });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _elapsed,
              style: TextStyle(fontSize: 50, fontFamily: 'Courier'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              OutlinedButton.icon(
                label: Text('Stop'),
                icon: Icon(Icons.stop),
                onPressed: () {
                  if (_stopWatch.isRunning)
                    _stopWatch.stop();
                  else
                    _stopWatch.reset();
                },
              ),
              OutlinedButton.icon(
                label: Text('Play'),
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  _stopWatch.start();
                },
              )
            ]),
          ],
        ),
      ),
    );
  }
}

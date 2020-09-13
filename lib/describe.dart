import 'package:camera/camera.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guru_sadaka/util/asana.dart';
// import 'package:guru_sadaka/util/pose_description.dart';
import 'dart:async';

class DescribePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String customModel;
  final AsanaModel indexAsana;

  DescribePage(
      {Key key, this.cameras, this.title, this.customModel, this.indexAsana})
      : super(key: key);

  @override
  _DescribePageState createState() => _DescribePageState(
      this.cameras, this.title, this.customModel, this.indexAsana);
}

class _DescribePageState extends State<DescribePage> {
  final List<CameraDescription> cameras;
  final String title;
  final String customModel;
  final AsanaModel indexAsana;

  _DescribePageState(
      this.cameras, this.title, this.customModel, this.indexAsana);

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void resetTimer() {
    flutterTts.stop();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 10) {
            _start = 10;
            timer.cancel();
          }
        },
      ),
    );
  }

  final FlutterTts flutterTts = FlutterTts();
  @override
  void dispose() {
    resetTimer();
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage('en-IN');
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.75);
      await flutterTts.speak(indexAsana.doc);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          Card(
            color: Colors.pink[50],
            elevation: 20,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                new Container(
                    width: MediaQuery.of(context).size.height * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: indexAsana.picurl == null
                                ? AssetImage(
                                    'assets/images/profile-image.png',
                                  )
                                : NetworkImage(indexAsana.picurl)))),
                SizedBox(
                  height: 10,
                ),
                new Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.pink[10],
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    indexAsana.doc,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 60,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        "$_start",
                        style: GoogleFonts.getFont('Open Sans',
                            fontSize: 40, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton.icon(
                      onPressed: () => startTimer(),
                      icon: Icon(Icons.speaker),
                      label: Text('Start'),
                      color: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RaisedButton.icon(
                      onPressed: () => resetTimer(),
                      icon: Icon(Icons.refresh),
                      label: Text('Reset'),
                      color: Colors.lightBlueAccent,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  //elevation: 10,
                  color: Colors.white,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    'Analytics on pose',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton.icon(
                      onPressed: () => _speak(),
                      icon: Icon(Icons.speaker),
                      label: Text('Speak'),
                      color: Colors.lime,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton.icon(
                      onPressed: () => _speak(),
                      icon: Icon(Icons.assessment),
                      label: Text('Compare Pose'),
                      color: Colors.lime,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
CircularCountDownTimer(
      duration: indexAsana.time,
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 5,
      color: Colors.white,
      fillColor: Colors.red,
      strokeWidth: 5.0,
      textStyle: TextStyle(
          fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold),
      isReverse: false,
      isTimerTextShown: true,
      onComplete: () {
        // Here, do whatever you want
      },
    )
*/

/*
class DescribePage extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String customModel;
  final AsanaModel indexAsana;

  DescribePage({
    Key key,
    this.cameras,
    this.title,
    this.customModel,
    this.indexAsana,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              new Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: indexAsana.picurl == null
                              ? AssetImage(
                                  'assets/images/profile-image.png',
                                )
                              : NetworkImage(indexAsana.picurl)))),
              new Container(
                color: Colors.white,
                child: Text(indexAsana.doc),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/

// "assets/poses/" + title + ".png",

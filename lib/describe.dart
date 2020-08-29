import 'package:camera/camera.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guru_sadaka/util/asana.dart';
import 'package:guru_sadaka/util/pose_description.dart';
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

  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.pause();
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(indexAsana.doc);
    }

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          Card(
            //color: Colors.yellow[50],
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
                Row(
                  children: [
                    clock(),
                    Column(
                      children: [
                        RaisedButton.icon(
                            onPressed: () => _speak(),
                            icon: Icon(Icons.speaker),
                            label: null),
                        RaisedButton.icon(
                            onPressed: () => clock(),
                            icon: Icon(Icons.refresh),
                            label: null)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget clock() {
    return CircularCountDownTimer(
      duration: indexAsana.time,
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 5,
      color: Colors.white,
      fillColor: Colors.red,
      strokeWidth: 5.0,
      textStyle: TextStyle(
          fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold),
      isReverse: true,
      isTimerTextShown: true,
      onComplete: () {
        // Here, do whatever you want
      },
    );
  }
}

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

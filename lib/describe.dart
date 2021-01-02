import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guru_sadaka/util/asana.dart';
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
    // _start = 10;
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.grey[600])),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              new Container(
                  width: MediaQuery.of(context).size.height * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[600],
                      ),
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  indexAsana.doc,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "$_start",
                      style: GoogleFonts.getFont('Open Sans',
                          fontSize: 40, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  IconButton(
                    icon: Icon(Ionicons.md_alarm),
                    onPressed: () {
                      startTimer();
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.restart),
                    onPressed: () {
                      resetTimer();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Analytics',
                style: GoogleFonts.getFont(
                  'Open Sans',
                  fontSize: 40,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Card(
                    color: Colors.blue,
                    child: IconButton(
                      icon: Icon(MaterialCommunityIcons.text_to_speech),
                      onPressed: () {
                        _speak();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  RaisedButton.icon(
                    onPressed: () => _speak(),
                    icon: Icon(Icons.assessment),
                    label: Text('Compare Pose'),
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              )
            ],
          ),
        ],
      ),
    );
  }
}

// "assets/poses/" + title + ".png",

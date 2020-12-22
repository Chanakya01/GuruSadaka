import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guru_sadaka/describe.dart';
import 'package:guru_sadaka/inference.dart';
import 'package:guru_sadaka/util/Section.dart';
import 'package:guru_sadaka/util/asana.dart';

class Poses extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String model;
  final List asanas;
  final Color color;
  const Poses({this.cameras, this.title, this.model, this.asanas, this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.black)),
        shadowColor: Colors.black,
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            color: Colors.pink[50],
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.5,
              child: RaisedButton(
                elevation: 20,
                color: Colors.redAccent,
                onPressed: () =>
                    _onclick(context, asanas[index]["Name"], index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: asanas[index]['PicUrl'] == null
                          ? AssetImage(
                              'assets/images/profile-image.png',
                            )
                          : NetworkImage(asanas[index]['PicUrl']),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      asanas[index]["Name"],
                      style: GoogleFonts.getFont(
                        'Lato',
                        textStyle:
                            TextStyle(color: Colors.white, letterSpacing: .5),
                        fontSize: 25,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: asanas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  void _onSelect(BuildContext context, String customModelName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InferencePage(
          cameras: cameras,
          title: customModelName,
          model: "assets/models/yoga_classifier.tflite",
          customModel: customModelName,
        ),
      ),
    );
  }

  void _onclick(BuildContext context, String customModelName, int index) async {
    AsanaModel asanaModel = new AsanaModel();
    asanaModel.setAsana(this.asanas[index]);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescribePage(
          cameras: cameras,
          title: customModelName,
          indexAsana: asanaModel,
          customModel: customModelName,
        ),
      ),
    );
  }
}

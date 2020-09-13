import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guru_sadaka/describe.dart';
import 'package:guru_sadaka/inference.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
          itemCount: asanas.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 75,
              child: Card(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () =>
                      _onclick(context, asanas[index]["Name"], index),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: asanas[index]['PicUrl'] == null
                            ? AssetImage(
                                'assets/images/profile-image.png',
                              )
                            : NetworkImage(asanas[index]['PicUrl']),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        asanas[index]["Name"],
                        style: GoogleFonts.getFont('Open Sans'),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
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

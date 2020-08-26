import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'inference.dart';

class AsanaList extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String model;
  final List<String> asanas;
  final Color color;

  const AsanaList(
      {Key key, this.cameras, this.title, this.model, this.asanas, this.color})
      : super(key: key);

  //const Poses({this.cameras, this.title, this.model, this.asanas, this.color});

  //const AsanaList({Key key}) : super(key: key);

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
        //padding: EdgeInsets.all(20),
        children: [
          ListView.builder(
            itemCount: asanas.length,
            itemBuilder: (context, position) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    asanas[position],
                    //style: TextStyle(fontSize: 10.0),
                  ),
                ),
              );
            },
          )
        ],
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
}

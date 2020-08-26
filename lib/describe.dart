import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:guru_sadaka/util/pose_description.dart';

class DescribePage extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String customModel;
  final int indexAsana;

  const DescribePage(
      {Key key, this.cameras, this.title, this.customModel, this.indexAsana})
      : super(key: key);
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
                        image: AssetImage("assets/poses/" + title + ".png"),
                      ))),
              new Container(
                color: Colors.white,
                child: Text(beginnerdescription[indexAsana]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// "assets/poses/" + title + ".png",

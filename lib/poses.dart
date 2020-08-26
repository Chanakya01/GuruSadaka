import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:guru_sadaka/describe.dart';
import 'package:guru_sadaka/inference.dart';
import 'package:guru_sadaka/yoga_card.dart';

class Poses extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String model;
  final List<String> asanas;
  final Color color;

  const Poses({this.cameras, this.title, this.model, this.asanas, this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.yellow[50],
        centerTitle: true,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Container(
          height: 500,
          child: Swiper(
            itemCount: asanas.length,
            loop: false,
            viewportFraction: 0.3,
            scale: 0.82,
            outer: true,
            scrollDirection: Axis.vertical,
            /* pagination: SwiperPagination(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10.0),
            ),*/
            onTap: (index) => _onclick(context, asanas[index], index),
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      child: YogaCard(
                        asana: asanas[index],
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescribePage(
          cameras: cameras,
          title: customModelName,
          indexAsana: index,
          customModel: customModelName,
        ),
      ),
    );
  }
}

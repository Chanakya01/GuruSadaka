import 'package:camera/camera.dart';
import 'package:favorite_button/favorite_button.dart';
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
  List filteredAsanas;
  final Color color;
  Poses({this.cameras, this.title, this.model, this.asanas, this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Colors.grey[600],
            fontWeight: FontWeight.w700,
          ),
        ),
        shadowColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: new TextEditingController(),
              decoration: InputDecoration(
                hintText: 'Search Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(child: getList())
        ],
      ),
    );
  }

  onItemChanged(String value) {
    filteredAsanas = asanas;
    if (value != "") {
      filteredAsanas = asanas
          .where((c) => c["Name"].toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  Widget getList() {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(bottom: 1),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.065,
            child: RaisedButton(
              elevation: 20,
              color: Colors.white,
              onPressed: () => _onclick(context, asanas[index]["Name"], index),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
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
                    style: GoogleFonts.getFont(
                      'Lato',
                      textStyle:
                          TextStyle(color: Colors.black87, letterSpacing: .5),
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  FavoriteButton(
                    isFavorite: false,
                    iconColor: Colors.pinkAccent,
                    iconSize: 50,
                    valueChanged: (_isFavorite) {
                      print('Is Favorite : $_isFavorite');
                    },
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

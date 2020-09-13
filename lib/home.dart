import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:guru_sadaka/asanaList.dart';
import 'package:guru_sadaka/login.dart';
import 'package:guru_sadaka/poses.dart';
import 'package:guru_sadaka/profile.dart';
import 'package:guru_sadaka/scale_route.dart';
import 'package:guru_sadaka/size_route.dart';
import 'package:guru_sadaka/util/Header.dart';
import 'package:guru_sadaka/util/Image_card2.dart';
import 'package:guru_sadaka/util/Image_card_1.dart';
import 'package:guru_sadaka/util/LevelModel.dart';
import 'package:guru_sadaka/util/Section.dart';
import 'package:guru_sadaka/util/pose_data.dart';
import 'package:guru_sadaka/util/auth.dart';
import 'package:guru_sadaka/util/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'poses.dart';

class Home extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  static List<Object> levels;
  final List<CameraDescription> cameras;

  static final Firestore _firestore = Firestore.instance;
  const Home({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    User user = User();
    tapFunction(index) {
      var routePages = [
        '/',
        '/dashboard',
        '/profile',
      ];
      switch (routePages[index]) {
        case '/':
          {
            Navigator.of(context).pushNamed('/');
          }
          break;
        case '/dashboard':
          {
            Navigator.of(context).pushNamed('/');
          }
          break;
        case '/profile':
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    email: user.email,
                    uid: user.uid,
                    displayName: user.displayName,
                    photoUrl: user.photoUrl,
                  ),
                ));
          }
          break;
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Header(
                    'Programs',
                    rightSide: null,
                  ),
                  // MainCardPrograms(), // MainCard
                  Section(
                    title: 'Generic Schedule',
                    horizontalList: this.generateList(context),
                  ),
                  Section(
                    title: 'Your Schedule',
                    horizontalList: <Widget>[
                      ImageCardWithInternal(
                        image: 'assets/images/favourite.png',
                        title: 'Favourite \nWorkout',
                        duration: '10 min',
                      ),
                      ImageCardWithInternal(
                        image: 'assets/images/tutor.png',
                        title: 'Tutorial \nWorkout',
                        duration: '12 min',
                      ),
                    ],
                  ),
                  //  Container(
                  //   margin: EdgeInsets.only(top: 50.0),
                  //   padding: EdgeInsets.only(top: 10.0, bottom: 40.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue[50],
                  //   ),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Section(
                  //         title: 'Daily Tips',
                  //         horizontalList: <Widget>[
                  //           UserTip(
                  //             image: 'assets/images/image010.jpg',
                  //             name: 'User Img',
                  //           ),
                  //           UserTip(
                  //             image: 'assets/images/image010.jpg',
                  //             name: 'User Img',
                  //           ),
                  //           UserTip(
                  //             image: 'assets/images/image010.jpg',
                  //             name: 'User Img',
                  //           ),
                  //           UserTip(
                  //             image: 'assets/images/image010.jpg',
                  //             name: 'User Img',
                  //           ),
                  //         ],
                  //       ),
                  //       Section(
                  //         horizontalList: <Widget>[
                  //           DailyTip(),
                  //           DailyTip(),
                  //           DailyTip(),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => tapFunction(value),
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(FontAwesome.home),
            ),
            BottomNavigationBarItem(
              title: Text('Dashboard'),
              icon: Icon(FontAwesome.dashboard),
            ),
            BottomNavigationBarItem(
              title: Text('Account'),
              icon: Icon(FontAwesome.user),
            ),
          ],
          backgroundColor: Colors.white,
        ));
  }

  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    levels[0] = new LevelModel(
        title: 'Beginner',
        difficult: 'low',
        image: 'assets/images/favourite.png');
    levels[1] = new LevelModel(
        title: 'Intermediate',
        difficult: 'medium',
        image: 'assets/images/favourite.png');
    levels[2] = new LevelModel(
        title: 'Expert',
        difficult: 'hard',
        image: 'assets/images/favourite.png');
    int count = 0;
    levels.forEach((level) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: ImageCardWithBasicFooter(
            level: level,
            tag: 'imageHeader$count',
          ),
          onTap: () {
            _onPoseSelect(
              context,
              level,
              Colors.green,
            );
          },
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }

  void _onPoseSelect(
    BuildContext context,
    LevelModel level,
    Color color,
  ) async {
    List asanas = new List();
    await _firestore
        .collection("Asanas")
        .where("Type", isEqualTo: level.title)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        asanas.add(result.data);
      });
    });
    Navigator.push(
      context,
      ScaleRoute(
        page: Poses(
          cameras: cameras,
          title: level.title,
          model: "assets/models/yoga_classifier.tflite",
          asanas: asanas,
          color: color,
        ),
      ),
    );
  }
}

class CircleProfileImage extends StatefulWidget {
  final User user;
  const CircleProfileImage({this.user});

  @override
  _CircleProfileImageState createState() => _CircleProfileImageState(user);
}

class _CircleProfileImageState extends State<CircleProfileImage> {
  final User user;

  _CircleProfileImageState(this.user);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile',
      child: Center(
        child: CircleAvatar(
          radius: 15,
          backgroundImage: true
              ? AssetImage(
                  'assets/images/profile-image.png',
                )
              // ignore: dead_code
              : NetworkImage(user.photoUrl),
        ),
      ),
    );
  }
}

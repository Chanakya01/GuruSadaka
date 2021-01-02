import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:guru_sadaka/poses.dart';
import 'package:guru_sadaka/profile.dart';
import 'package:guru_sadaka/raids.dart';
import 'package:guru_sadaka/scale_route.dart';
import 'package:guru_sadaka/util/Header.dart';
import 'package:guru_sadaka/util/Image_card2.dart';
import 'package:guru_sadaka/util/Image_card_1.dart';
import 'package:guru_sadaka/util/LevelModel.dart';
import 'package:guru_sadaka/util/Section.dart';
import 'package:guru_sadaka/util/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'poses.dart';

class Home extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  static List<LevelModel> levels = [];
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
    navigateSlides(index) {
      var workouts = ['/pank', '/tops'];
      switch (workouts[index]) {
        case '/plank':
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                          email: user.email,
                          uid: user.uid,
                          displayName: user.displayName,
                          photoUrl: user.photoUrl,
                        )));
          }
          break;
        case '/tops':
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                          email: user.email,
                          uid: user.uid,
                          displayName: user.displayName,
                          photoUrl: user.photoUrl,
                        )));
          }
          break;
      }
    }

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
        // case '/workout':
        //  Navigator.push(context,
        //    MaterialPageRoute(builder: (context) => ActivityDetail()));
        // break;
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
                      FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivityDetail(
                                    email: user.email,
                                    uid: user.uid,
                                    displayName: user.displayName,
                                    photoUrl: user.photoUrl))),
                        child: ImageCardWithInternal(
                          image: 'assets/images/favourite.png',
                          title: 'Create own \nWorkout',
                          duration: '10 min',
                        ),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivityDetail(
                                    email: user.email,
                                    uid: user.uid,
                                    displayName: user.displayName,
                                    photoUrl: user.photoUrl))),
                        child: ImageCardWithInternal(
                          image: 'assets/images/tutor.png',
                          title: 'Your \nWorkout',
                          duration: '12 min',
                        ),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivityDetail(
                                    email: user.email,
                                    uid: user.uid,
                                    displayName: user.displayName,
                                    photoUrl: user.photoUrl))),
                        child: ImageCardWithInternal(
                          image: 'assets/images/tutorial.jpg',
                          title: 'Tutorial \nConnect',
                          duration: '2 hr',
                        ),
                      ),
                    ],
                  ),
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
    List<LevelModel> levels = [];
    levels.add(new LevelModel(
        title: 'Beginner',
        difficult: 'low',
        image: 'assets/images/favourite.png'));
    levels.add(new LevelModel(
        title: 'Intermediate',
        difficult: 'medium',
        image: 'assets/images/favourite.png'));
    levels.add(new LevelModel(
        title: 'Expert',
        difficult: 'hard',
        image: 'assets/images/favourite.png'));
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

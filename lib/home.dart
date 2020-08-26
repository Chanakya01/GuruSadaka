import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:guru_sadaka/asanaList.dart';
import 'package:guru_sadaka/login.dart';
import 'package:guru_sadaka/poses.dart';
import 'package:guru_sadaka/profile.dart';
import 'package:guru_sadaka/scale_route.dart';
import 'package:guru_sadaka/size_route.dart';
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
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Guru Sadaka', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(
                  email: user.email,
                  uid: user.uid,
                  displayName: user.displayName,
                  photoUrl: user.photoUrl,
                ),
              ),
            ),
            child: CircleProfileImage(
              user: user,
            ),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () async {
              Auth auth = Auth();
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(
                    cameras: cameras,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 220,
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () => _onPoseSelect(
                context,
                'Beginner',
                Colors.green,
              ),
              child: Card(
                elevation: 5,
                //color: Gradient(colors: null),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/poses/Bhujangasana.png'),
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Beginner',
                      style: TextStyle(color: Colors.pink, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 220,
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () => _onPoseSelect(
                context,
                'Intermediate',
                Colors.green,
              ),
              child: Card(
                elevation: 5,
                //color: Gradient(colors: null),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/poses/Padhastasana.png'),
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Intermediate',
                      style: TextStyle(color: Colors.pink, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 220,
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () => _onPoseSelect(
                context,
                'Advanced',
                Colors.green,
              ),
              child: Card(
                elevation: 5,
                //color: Gradient(colors: null),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/poses/Bakasana.png'),
                      width: 175,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Advanced',
                      style: TextStyle(color: Colors.pink, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         // Welcome Text
      //         Padding(
      //           padding: const EdgeInsets.all(32.0),
      //           child: Text(
      //             'Welcome\n${user.displayName}',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 26,
      //               color: Colors.black87,
      //             ),
      //           ),
      //         ),

      //         // Beginner Button
      //         Padding(
      //           padding: const EdgeInsets.all(32.0),
      //           child: Card(
      //             elevation: 10,
      //             child: Column(
      //               children: [
      //                 Image(
      //                   image: AssetImage('assets/poses/Bakasana.png'),
      //                 ),
      //                 ButtonTheme(
      //                   minWidth: 200,
      //                   height: 60,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(30),
      //                   ),
      //                   child: FlatButton(
      //                     color: Colors.green,
      //                     child: Text(
      //                       'Beginner',
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                     onPressed: () => _onPoseSelect(
      //                       context,
      //                       'Beginner',
      //                       beginnerAsanas,
      //                       Colors.green,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),

      //         // Intermediate Button
      //         Padding(
      //           padding: const EdgeInsets.all(32.0),
      //           child: ButtonTheme(
      //             minWidth: 200,
      //             height: 60,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(30),
      //             ),
      //             child: FlatButton(
      //               color: Colors.blue,
      //               child: Text(
      //                 'Intermediate',
      //                 style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               onPressed: () => _onPoseSelect(
      //                 context,
      //                 'Intermediate',
      //                 intermediateAsanas,
      //                 Colors.blue,
      //               ),
      //             ),
      //           ),
      //         ),

      //         // Advance Button
      //         Padding(
      //           padding: const EdgeInsets.all(32.0),
      //           child: ButtonTheme(
      //             minWidth: 200,
      //             height: 60,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(30),
      //             ),
      //             child: FlatButton(
      //               color: Colors.deepPurple,
      //               child: Text(
      //                 'Advance',
      //                 style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               onPressed: () => _onPoseSelect(
      //                 context,
      //                 'Advance',
      //                 advanceAsanas,
      //                 Colors.deepPurple[400],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void _onPoseSelect(
    BuildContext context,
    String title,
    Color color,
  ) async {
    List asanas = new List();
    await _firestore
        .collection("Asanas")
        .where("Type", isEqualTo: title)
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
          title: title,
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

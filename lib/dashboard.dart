import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        //    BottomBarView(
        //       tabIconsList: tabIconsList,
        //       addClick: () {},
        //       changeIndex: (int index) {
        //         if (index == 0 || index == 2) {
        //           animationController.reverse().then<dynamic>((data) {
        //             if (!mounted) {
        //               return;
        //             }
        //             setState(() {
        //               tabBody =
        //                   MyDiaryScreen(animationController: animationController);
        //             });
        //           });
        //         } else if (index == 1 || index == 3) {
        //           animationController.reverse().then<dynamic>((data) {
        //             if (!mounted) {
        //               return;
        //             }
        //             setState(() {
        //               tabBody =
        //                   TrainingScreen(animationController: animationController);
        //             });
        //           });
        //         }
        //       },
        //     ),
      ],
    );
  }
}

/*

class BottomBarView extends StatefulWidget {
  const BottomBarView(
      {Key key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;
  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: PhysicalShape(
                color: FitnessAppTheme.white,
                elevation: 16.0,
                clipper: TabClipper(
                    radius: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                                parent: animationController,
                                curve: Curves.fastOutSlowIn))
                            .value *
                        38.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 62,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList[0],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList[0]);
                                    widget.changeIndex(0);
                                  }),
                            ),
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList[1],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList[1]);
                                    widget.changeIndex(1);
                                  }),
                            ),
                            SizedBox(
                              width: Tween<double>(begin: 0.0, end: 1.0)
                                      .animate(CurvedAnimation(
                                          parent: animationController,
                                          curve: Curves.fastOutSlowIn))
                                      .value *
                                  64.0,
                            ),
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList[2],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList[2]);
                                    widget.changeIndex(2);
                                  }),
                            ),
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList[3],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList[3]);
                                    widget.changeIndex(3);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 + 62.0,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Curves.fastOutSlowIn)),
                    child: Container(
                      // alignment: Alignment.center,s
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyDarkBlue,
                        gradient: LinearGradient(
                            colors: [
                              FitnessAppTheme.nearlyDarkBlue,
                              HexColor('#6A88E5'),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.nearlyDarkBlue
                                  .withOpacity(0.4),
                              offset: const Offset(8.0, 16.0),
                              blurRadius: 16.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(0.1),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            widget.addClick();
                          },
                          child: Icon(
                            Icons.add,
                            color: FitnessAppTheme.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}



// @override
// Widget build(BuildContext context) {

//   return Scaffold(
//     backgroundColor: Colors.pink[50],
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       title: Text('Guru Sadaka', style: TextStyle(color: Colors.black)),
//       centerTitle: true,
//       actions: <Widget>[
//         // GestureDetector(
//         //   onTap: () => Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => Profile(
//         //         email: user.email,
//         //         uid: user.uid,
//         //         displayName: user.displayName,
//         //         photoUrl: user.photoUrl,
//         //       ),
//         //     ),
//         //   ),
//         //   child: CircleProfileImage(
//         //     user: user,
//         //   ),
//         // ),
//         IconButton(
//           icon: Icon(Icons.exit_to_app, color: Colors.black),
//           onPressed: () async {
//             Auth auth = Auth();
//             await auth.signOut();
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Login(
//                   cameras: cameras,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     ),
//     body: ListView(
//       children: [
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//           height: 220,
//           width: double.maxFinite,
//           child: GestureDetector(
//             onTap: () => _onPoseSelect(
//               context,
//               'Beginner',
//               Colors.green,
//             ),
//             child: Card(
//               elevation: 5,
//               //color: Gradient(colors: null),
//               child: Row(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/poses/Bhujangasana.png'),
//                     width: 175,
//                     fit: BoxFit.cover,
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'Beginner',
//                     style: TextStyle(color: Colors.pink, fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//           height: 220,
//           width: double.maxFinite,
//           child: GestureDetector(
//             onTap: () => _onPoseSelect(
//               context,
//               'Intermediate',
//               Colors.green,
//             ),
//             child: Card(
//               elevation: 5,
//               //color: Gradient(colors: null),
//               child: Row(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/poses/Padhastasana.png'),
//                     width: 175,
//                     fit: BoxFit.cover,
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'Intermediate',
//                     style: TextStyle(color: Colors.pink, fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//           height: 220,
//           width: double.maxFinite,
//           child: GestureDetector(
//             onTap: () => _onPoseSelect(
//               context,
//               'Advanced',
//               Colors.green,
//             ),
//             child: Card(
//               elevation: 5,
//               //color: Gradient(colors: null),
//               child: Row(
//                 children: [
//                   Image(
//                     image: AssetImage('assets/poses/Bakasana.png'),
//                     width: 175,
//                     fit: BoxFit.cover,
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'Advanced',
//                     style: TextStyle(color: Colors.pink, fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//    ,
//   );
// }

// List<Widget> generateList(BuildContext context) {
//   List<Widget> list = [];
//   int count = 0;
//   levels.forEach((e) {
//     Widget element = Container(
//       margin: EdgeInsets.only(right: 20.0),
//       child: GestureDetector(
//         child: Card(
//           elevation: 5,
//           //color: Gradient(colors: null),
//           child: Row(
//             children: [
//               Image(
//                 image: AssetImage('assets/poses/Bhujangasana.png'),
//                 width: 175,
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 e,
//                 style: TextStyle(color: Colors.pink, fontSize: 20),
//               ),
//             ],
//           ),
//         ),
//         onTap: () => _onPoseSelect(
//           context,
//           'Beginner',
//           Colors.green,
//         ),
//       ),
//     );
//     list.add(element);
//     count++;
//   });
//   return list;
// }


*/

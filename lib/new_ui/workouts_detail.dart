import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutrical/dashboard.dart';
import 'package:nutrical/new_ui/list_workouts.dart';
import 'package:nutrical/new_ui/work_contain.dart';
import 'package:nutrical/new_ui/workout_type.dart';
import 'package:nutrical/new_ui/workouts_intro.dart';
import 'package:nutrical/ui/mealplan.dart';
import 'package:nutrical/ui/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:http/http.dart' as http;

class WorkoutsDetailPage extends StatefulWidget {
  @override
  _WorkoutsDetailPageState createState() => _WorkoutsDetailPageState();
}

class _WorkoutsDetailPageState extends State<WorkoutsDetailPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f3f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Dashboard(),
                ),
                (route) => false);
          },
        ),
        title: Text(
          'Choose your workout',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.1,
            color: Colors.black,
          ),
        ),
      ),
      body: SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
            circleColors: [Colors.white, Colors.redAccent, Colors.redAccent],
            iconTheme: IconThemeData(color: Colors.redAccent),
            activeIconTheme: IconThemeData(color: Colors.redAccent),
            activeTitleStyle: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            titleStyle: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(
              color: Colors.redAccent,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              elevation: 2,
            ),
            elevation: 2.0,
            items: [
              // Suggested count : 4
              SCBottomBarItem(
                  icon: Icons.home,
                  title: "Home",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: Dashboard(),
                        ),
                        (route) => false);
                  }),
              SCBottomBarItem(
                  icon: FontAwesomeIcons.running,
                  title: "Workouts",
                  onPressed: () {}),
              SCBottomBarItem(
                  icon: Icons.restaurant_outlined,
                  title: "Meals",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: MealPlan(),
                        ),
                        (route) => false);
                  }),
              SCBottomBarItem(
                  icon: Icons.settings,
                  title: "Settings",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ProfilePage(),
                      ),
                    );
                  }),
            ],
            circleItems: [
              //Suggested Count: 3
              SCItem(icon: Icon(Icons.assignment_outlined), onPressed: () {}),
              SCItem(icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
            ],
            bnbHeight: 75 // Suggested Height 80
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF29F29B),
                      Color(0xFF3e978b),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: gradientColor.last.withOpacity(0.4),
                  //     blurRadius: 8,
                  //     spreadRadius: 2,
                  //     offset: Offset(4, 4),
                  //   ),
                  // ],
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Beginner",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        right: 50.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'The Beginning is always tough. But once you are in it you will become Unstoppable.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: getapi('Beginner'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${snapshot.data['Count']} Exercises",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minWidth: 30.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text('VIEW',
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ListYourWorkouts(
                                          level: 'Beginner',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFf4e04d),
                      Color(0xFFf6d743),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: gradientColor.last.withOpacity(0.4),
                  //     blurRadius: 8,
                  //     spreadRadius: 2,
                  //     offset: Offset(4, 4),
                  //   ),
                  // ],
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Intermediate",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        right: 50.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'Push harder than yesterday, if you want a different tomorrow.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: getapi('Intermediate'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${snapshot.data['Count']} Exercises",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minWidth: 30.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text('VIEW',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ListYourWorkouts(
                                          level: 'Intermediate',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFf05454),
                      Color(0xFFaf2d2d),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: gradientColor.last.withOpacity(0.4),
                  //     blurRadius: 8,
                  //     spreadRadius: 2,
                  //     offset: Offset(4, 4),
                  //   ),
                  // ],
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Advanced",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        right: 50.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        'Champions keep playing until they get it right. No turning back!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: getapi('Advanced'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${snapshot.data['Count']} Exercises",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minWidth: 30.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text('VIEW',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ListYourWorkouts(
                                          level: 'Advanced',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map> getapi(String level) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.uid);
      }
    } catch (e) {
      print(e);
    }
    String api =
        'https://u7waim1mu0.execute-api.ap-south-1.amazonaws.com/v1/workindex/$level';

    http.Response response = await http.get(api);
    return json.decode(response.body);
  }
}

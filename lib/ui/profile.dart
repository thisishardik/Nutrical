import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bottom_sheet/flutter_bottom_sheet.dart';
import 'package:mobile_popup/mobile_popup.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nutrical/dashboard.dart';
import 'dart:convert';
import 'package:nutrical/model/bottomnav.dart' as bn;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nutrical/new_ui/workouts_intro.dart';
import 'package:nutrical/ui/login.dart';
import 'package:nutrical/ui/mealplan.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'dart:math' as math;

import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

int _currentIndex = 4;
String userID = '';
String name = '';
String email = '';
bool showSpinner = false;
bool isActive = false;

var healthProfile = {};

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  getCurrentUser() async {}

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                elevation: 2),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: WorkoutsIntroPage(),
                      ),
                    );
                  }),
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
                  icon: Icons.settings, title: "Settings", onPressed: () {}),
            ],
            circleItems: [
              //Suggested Count: 3
              SCItem(icon: Icon(Icons.assignment_outlined), onPressed: () {}),
              SCItem(icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
            ],
            bnbHeight: 75 // Suggested Height 80
            ),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getapi(),
              builder: (context, snapshot) {
                Map content = snapshot.data;
                print(content);
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 25.0,
                                bottom: 15.0),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3.0,
                                      offset: Offset(0, 1.5),
                                      color: Colors.black38),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(
                                    "images/female.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 5.0,
                              right: 15.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${loggedInUser.displayName}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${loggedInUser.email}",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Text(
                      //       'Email :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Flexible(
                      //       child: Text(
                      //         email,
                      //         textAlign: TextAlign.end,
                      //         style: TextStyle(
                      //             fontSize: 20.0,
                      //             fontWeight: FontWeight.w600,
                      //             color: Colors.orange[700]),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'DOB :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       '${content["Items"][0]["dob"]["S"]}',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'Gender :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       '${content['Items'][0]["gender"]['S']}',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'Height :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       '${content['Items'][0]["height"]['N']}',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'Weight :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       "${content['Items'][0]["weight"]['N']}",
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'Desired Weight :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       "${content['Items'][0]["d_weight"]['N']}",
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'BMI :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       "",
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       'Aim :',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //     Text(
                      //       '${content['Items'][0]["aim"]['S']}',
                      //       style: TextStyle(
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.orange[700]),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.025,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.pushNamed(context, '/update_profile');
                      //       },
                      //       child: Container(
                      //         child: Center(
                      //             child: Text(
                      //           'Update',
                      //           style: TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w700,
                      //               color: Colors.black54),
                      //         )),
                      //         height: MediaQuery.of(context).size.height * 0.05,
                      //         width: MediaQuery.of(context).size.width * 0.35,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           border: Border.all(
                      //               color: Colors.orange[600], width: 1.5),
                      //         ),
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Container(
                      //         child: Center(
                      //             child: Text(
                      //           'Premium',
                      //           style: TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w700,
                      //               color: Colors.black54),
                      //         )),
                      //         height: MediaQuery.of(context).size.height * 0.05,
                      //         width: MediaQuery.of(context).size.width * 0.35,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           border: Border.all(
                      //               color: Colors.orange[600], width: 1.5),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.03,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Container(
                      //         child: Center(
                      //             child: Text(
                      //           'Log Out',
                      //           style: TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w700,
                      //               color: Colors.black54),
                      //         )),
                      //         height: MediaQuery.of(context).size.height * 0.05,
                      //         width: MediaQuery.of(context).size.width * 0.35,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           border: Border.all(
                      //               color: Colors.orange[600], width: 1.5),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Account",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(
                          height: 15,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GFAccordion(
                        title: "User Settings",
                        titlePadding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        expandedIcon: Icon(Icons.close),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        contentBorder: Border.all(color: Colors.black12),
                        contentChild: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            '${content["Items"][0]["gender"]["S"]}',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            '${content["Items"][0]["dob"]["S"]}',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            '${content["Items"][0]["weight"]["S"]} kg',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            '${content["Items"][0]["height"]["S"]} cm',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            'BMI: ${content["Items"][0]["bmi"]["S"]}',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      buildAccountOptionRow(context, "Edit Profile", 1),
                      buildAccountOptionRow(context, "Change password", 2),
                      buildAccountOptionRow(context, "Language", 3),
                      buildAccountOptionRow(context, "Privacy and security", 4),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(
                          height: 15,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildNotificationOptionRow("Updates and Reminders",
                          (value) {
                        setState(() {
                          isActive = value;
                        });
                      }),

                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                bottom: 20.0,
                              ),
                              child: OutlineButton(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {},
                                child: Text("PREMIUM",
                                    style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                bottom: 20.0,
                              ),
                              child: OutlineButton(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  signOut();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "SIGN OUT",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> getapi() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        userID = loggedInUser.uid;
        print(loggedInUser.uid);
        name = loggedInUser.displayName;
        print(loggedInUser.displayName);
        email = loggedInUser.email;
        print(loggedInUser.email);
        print(loggedInUser.photoUrl);
        print(userID);
        String api =
            'https://419kmxl3nc.execute-api.ap-south-1.amazonaws.com/v1Ad/userid/$userID';
        http.Response response = await http.get(api);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}

Padding buildNotificationOptionRow(String title, Function onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 15.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: onChanged,
            ))
      ],
    ),
  );
}

GestureDetector buildAccountOptionRow(
    BuildContext context, String title, int flag) {
  return GestureDetector(
    onTap: () {
      if (flag == 1) {
        // CupertinoScaffold
        //     .showCupertinoModalBottomSheet(
        //   expand: true,
        //   context: context,
        //   backgroundColor: Colors.transparent,
        //   builder: (context, scrollController) =>
        //       Stack(
        //         children: <Widget>[
        //
        //           Positioned(
        //             height: 40,
        //             left: 40,
        //             right: 40,
        //             bottom: 20,
        //             child: MaterialButton(
        //               onPressed: () => Navigator.of(
        //                   context)
        //                   .popUntil((route) =>
        //               route.settings.name == '/'),
        //               child: Text('Pop back home'),
        //             ),
        //           )
        //         ],
        //       ),
        // )
        Navigator.pushNamed(context, '/update_profile');
      }
      if (flag == 2) {
        print("2 pressed");
        Navigator.pushNamed(context, '/update_profile');
      }
      if (flag == 3) {
        print("hello");
      }
      if (flag == 4) {
        print("hello");
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 19.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 15.0,
          ),
        ],
      ),
    ),
  );
}

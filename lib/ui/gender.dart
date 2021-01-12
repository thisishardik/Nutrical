import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:nutrical/model/BMI_Cal.dart';
import 'package:nutrical/new_ui/height_slider/height_humidity_screen.dart';
import 'package:nutrical/new_ui/weight_slider/weight_humidity_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../utilities.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:nutrical/model/BMI_Cal.dart' as bmical;

class Gender extends StatefulWidget {
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  //
  // final _auth = FirebaseAuth.instance;
  //
  // FirebaseUser loggedInUser;
  // _makePostRequest(String gender) async {
  //   try {
  //     final user = await _auth.currentUser();
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //       print(loggedInUser.uid);
  //
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   // set up POST requtgest arguments
  //   String url =
  //       'https://k0jf8nknvl.execute-api.ap-south-1.amazonaws.com/v1/profile-put-nc';
  //   Map<String, String> headers = {"Content-type": "application/json"};
  //
  //   String json =
  //       '{"userID": "${loggedInUser.uid}","gender": "$gender" }';
  //
  //
  //   if (gender == "") {
  //     _showErrorDialog('Please Fill all the fields');
  //   } else {
  //     Response response = await put(url, headers: headers, body: json);
  //     int statusCode = response.statusCode;
  //     String body = response.body;
  //     print(statusCode);
  //     print(response.body);
  //     print(response.bodyBytes);
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, '/your_weight', (route) => false);
  //   }
  // }
  Widget _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text('Authentication Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorMessage),
                ],
              ),
            ),
            actions: <Widget>[
              PlatformDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              PlatformDialogAction(
                child: Text('Ok'),
                actionType: ActionType.Preferred,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFED8F2F),
                      Color(0xFFF07030),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Column(
                children: [
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(90.0, 50.0, 0.0, 10.0),
                  //   child: Image.asset(
                  //     'images/gender.png',
                  //     scale: 4.0,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, left: 30.0, right: 30.0),
                    child: Text(
                      'Select Gender',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, left: 30.0, right: 30.0),
                    child: Text(
                      'We will make sure you get better',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0),
                    child: Text(
                      ' and personalized results',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            // GenderSelection(
            //   maleImage: AssetImage("images/male.png"),
            //   femaleImage: AssetImage("images/female.png"),
            //   selectedGenderIconBackgroundColor: Colors.green,
            //   selectedGenderIconColor: Colors.white,
            //   equallyAligned: true,
            //   animationDuration: Duration(milliseconds: 400),
            //   isCircular: true,
            //   isSelectedGenderIconCircular: true,
            //   opacityOfGradient: 0.6,
            //   padding: const EdgeInsets.all(3),
            //   size: 120,
            //   onChanged: (gender) {
            //     print(gender);
            //   },
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 50.0, 10.0, 10.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          print('Male pressed');
                          bmical.gender = "Male";
                          gender = 'Male';
                          if (gender == '') {
                            _showErrorDialog('Please Select Gender');
                          } else
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/your_weight', (route) => false);
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: WeightScreen(),
                              ),
                              (route) => false);
                          // _makePostRequest('Male');
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 51.0,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage('images/male.png'),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Male',
                              style: genderTextStyle,
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      '',
                      style: genderTextStyle,
                    )),
                  ),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          print('Female pressed');
                          bmical.gender = "Male";
                          if (gender == '') {
                            _showErrorDialog('Please Select Gender');
                          } else
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: HeightScreen(),
                                ),
                                (route) => false);
                          //  _makePostRequest('Female');
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 51.0,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    AssetImage('images/female.png'),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Female',
                              style: genderTextStyle,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrical/model/height_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:http/http.dart';
import 'package:nutrical/model/BMI_Cal.dart' as bmical;

class Your_Height extends StatefulWidget {
  @override
  _Your_HeightState createState() => _Your_HeightState();
}

class _Your_HeightState extends State<Your_Height> {
  int height = 170;
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  _makePostRequest(int height) async {
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
    // set up POST request arguments
    String url =
        'https://419kmxl3nc.execute-api.ap-south-1.amazonaws.com/v1Ad/userid/${loggedInUser.uid}';
    Map<String, String> headers = {"Content-type": "application/json"};

    String json = '{"userID": "${loggedInUser.uid}","height": "$height" }';

    if (height == "") {
      _showErrorDialog('Please Fill all the fields');
    } else {
      Response response = await put(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      String body = response.body;
      print(statusCode);
      print(response.body);
      print(response.bodyBytes);
      Navigator.pushNamedAndRemoveUntil(context, '/bmi', (route) => false);
    }
  }

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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF07030),
                      Color(0xFFED8F2F),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                  child: Text(
                'Height',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500),
              )),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 30.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.68,
              child: HeightSlider(
                  height: height,
                  minHeight: 120,
                  maxHeight: 200,
                  onChange: (value) {
                    setState(() {
                      height = value;
                      bmical.height = value;
                    });
                  }),
            ),
            Divider(
              thickness: 0.5,
              indent: 35.0,
              endIndent: 35.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: () {
                // _makePostRequest(height.toString());
                print(bmical.height);
                bmical.finalheight = bmical.height.toString();
                if (bmical.finalheight == '') {
                  _showErrorDialog('Please Fill It');
                } else
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/bmi', (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.orange,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 45.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

///*****************************
///
///
/// OLD CODE
///
///
/// ****************************
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nutrical/model/height_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:platform_alert_dialog/platform_alert_dialog.dart';
// import 'package:http/http.dart';
// import 'package:nutrical/model/BMI_Cal.dart' as bmical;
//
// class Your_Height extends StatefulWidget {
//   @override
//   _Your_HeightState createState() => _Your_HeightState();
// }
//
// class _Your_HeightState extends State<Your_Height> {
//   int height = 170;
//   // final _auth = FirebaseAuth.instance;
//   //
//   // FirebaseUser loggedInUser;
//   //
//   // _makePostRequest(String height) async {
//   //   try {
//   //     final user = await _auth.currentUser();
//   //     if (user != null) {
//   //       loggedInUser = user;
//   //       print(loggedInUser.email);
//   //       print(loggedInUser.uid);
//   //
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   //   // set up POST requtgest arguments
//   //   String url =
//   //       'https://k0jf8nknvl.execute-api.ap-south-1.amazonaws.com/v1/profile-put-nc';
//   //   Map<String, String> headers = {"Content-type": "application/json"};
//   //
//   //   String json =
//   //       '{"userID": "${loggedInUser.uid}","height": "$height" }';
//   //
//   //
//   //   if (height == "") {
//   //     _showErrorDialog('Please Fill all the fields');
//   //   } else {
//   //     Response response = await put(url, headers: headers, body: json);
//   //     int statusCode = response.statusCode;
//   //     String body = response.body;
//   //     print(statusCode);
//   //     print(response.body);
//   //     print(response.bodyBytes);
//   //     Navigator.pushNamedAndRemoveUntil(
//   //         context, '/bmi', (route) => false);
//   //   }
//   // }
//
//   Widget _showErrorDialog(String errorMessage) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return PlatformAlertDialog(
//             title: Text('Authentication Error'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text(errorMessage),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               PlatformDialogAction(
//                 child: Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               PlatformDialogAction(
//                 child: Text('Ok'),
//                 actionType: ActionType.Preferred,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.20,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50.0),
//                     bottomRight: Radius.circular(50.0),
//                   ),
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFFF07030),
//                       Color(0xFFED8F2F),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   )),
//               child: Center(
//                   child: Text(
//                 'Your Height',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.w500),
//               )),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                   top: 10.0, bottom: 15.0, left: 10.0, right: 30.0),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.80,
//               child: HeightSlider(
//                 height: height,
//                 minHeight: 120,
//                 maxHeight: 200,
//                 onChange: (val) => setState(() => height = val),
//               ),
//             ),
//             Divider(
//               thickness: 0.5,
//               indent: 35.0,
//               endIndent: 35.0,
//               color: Colors.black,
//             ),
//             GestureDetector(
//               onTap: () {
//                 // _makePostRequest(height.toString());
//                 print(bmical.height);
//                 bmical.finalheight = bmical.height.toString();
//                 if (bmical.finalheight == '') {
//                   _showErrorDialog('Please Fill It');
//                 } else
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, '/bmi', (route) => false);
//               },
//               child: Container(
//                 margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                 padding: EdgeInsets.only(right: 10.0, bottom: 20.0),
//                 height: MediaQuery.of(context).size.height * 0.10,
//                 width: MediaQuery.of(context).size.width * 0.20,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black45),
//                   borderRadius: BorderRadius.circular(100.0),
//                   color: Colors.orange,
//                 ),
//                 child: Icon(
//                   Icons.chevron_right,
//                   color: Colors.white,
//                   size: 80.0,
//                 ),
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

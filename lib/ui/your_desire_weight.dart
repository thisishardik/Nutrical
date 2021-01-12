import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;
import 'package:nutrical/model/BMI_Cal.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Your_Desire_Weight extends StatefulWidget {
  @override
  _Your_Desire_WeightState createState() => _Your_Desire_WeightState();
}

class _Your_Desire_WeightState extends State<Your_Desire_Weight> {
  double desired_weight = 0.0;

  // final _auth = FirebaseAuth.instance;
  // FirebaseUser loggedInUser;
  //
  // _makePostRequest(double desiredWeight) async {
  //   try {
  //     final user = await _auth.currentUser();
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //       print(loggedInUser.uid);
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
  //       '{"userID": "${loggedInUser.uid}","d_weight": "$desiredWeight" }';
  //
  //   if (desiredWeight.toString() == "") {
  //     _showErrorDialog('Please Fill all the fields');
  //   } else {
  //     http.Response response =
  //         await http.put(url, headers: headers, body: json);
  //     int statusCode = response.statusCode;
  //     String body = response.body;
  //     print(statusCode);
  //     print(response.body);
  //     print(response.bodyBytes);
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, '/select_diet', (route) => false);
  //   }
  // }
  //
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
              height: MediaQuery.of(context).size.height * 0.20,
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
                'Your Desired Weight',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500),
              )),
            ),

            //women_desire_weight image
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Image.asset('images/women_desire_weight.png'),
            ),

            Container(
              margin: EdgeInsets.all(10),
              height: 120,
              child: HorizantalPicker(
                minValue: 0,
                maxValue: 120,
                divisions: 120,
                initialPosition: InitialPosition.center,
                suffix: " Kg",
                showCursor: false,
                backgroundColor: Colors.transparent,
                activeItemTextColor: Colors.black,
                passiveItemsTextColor: Colors.black45,
                onChanged: (value) {
                  desired_weight = value;
                  setState(() {
                    print("Desired weight: $desired_weight");
                  });
                },
              ),
            ),

            //continue button
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
              height: 50.0,
              width: double.maxFinite,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                onPressed: () {
                  print('Continue pressed');
                  //_makePostRequest(desired_weight);
                  d_weight = desired_weight.toString();
                  if (d_weight == '') {
                    _showErrorDialog('Please Select Your Desired Weight');
                  } else
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/dashboard', (route) => false);
                },
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    gradient: LinearGradient(
                      colors: [Colors.orange[700], Colors.orange[200]],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

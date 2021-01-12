import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutrical/model/BMI_Cal.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:http/http.dart' as http;

class Your_Purpose extends StatefulWidget {
  @override
  _Your_PurposeState createState() => _Your_PurposeState();
}

class _Your_PurposeState extends State<Your_Purpose> {
  // final _auth = FirebaseAuth.instance;
  // FirebaseUser loggedInUser;
  //
  // _makePostRequest(String purpose) async {
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
  //   String json = '{"userID": "${loggedInUser.uid}","aim": "$purpose" }';
  //
  //   if (purpose == "") {
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
  //         context, '/your_desire_weight', (route) => false);
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.17,
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
                  'Your Purpose',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      aim = 'Gain Weight';
                      if (aim == '') {
                        _showErrorDialog('Please Select Your Purpose');
                      } else
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/your_desire_weight', (route) => false);
                      // _makePostRequest('Gain Weight');
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFe3f2fd),
                      ),
                      child: Center(child: Text('Gain Weight')),
                    ),
                  )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      //_makePostRequest('Lose Weight');
                      aim = 'Lose Weight';
                      if (aim == '') {
                        _showErrorDialog('Please Select Your Purpose');
                      } else
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/your_desire_weight', (route) => false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFe3f2fd),
                      ),
                      child: Center(child: Text('Lose Weight')),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      //_makePostRequest('Maintain Weight');
                      aim = 'Maintain Weight';
                      if (aim == '') {
                        _showErrorDialog('Please Select Your Purpose');
                      } else
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/your_desire_weight', (route) => false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFe3f2fd),
                      ),
                      child: Center(child: Text('Maintain Weight')),
                    ),
                  )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      //  _makePostRequest('Muscle Weight');
                      aim = 'Muscle Weight';
                      if (aim == '') {
                        _showErrorDialog('Please Select Your Purpose');
                      } else
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/your_desire_weight', (route) => false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFe3f2fd),
                      ),
                      child: Center(child: Text('Muscle Weight')),
                    ),
                  )),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //     padding: EdgeInsets.only(right: 10.0, bottom: 20.0),
            //     height: MediaQuery.of(context).size.height * 0.10,
            //     width: MediaQuery.of(context).size.width * 0.20,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black45),
            //       borderRadius: BorderRadius.circular(100.0),
            //       color: Colors.orange,
            //     ),
            //     child: Icon(
            //       Icons.chevron_right,
            //       color: Colors.white,
            //       size: 80.0,
            //     ),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}

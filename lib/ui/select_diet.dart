import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrical/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:nutrical/model/BMI_Cal.dart';
import 'package:page_transition/page_transition.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Select_Diet extends StatefulWidget {
  @override
  _Select_DietState createState() => _Select_DietState();
}

class _Select_DietState extends State<Select_Diet> {
  List<String> items = ['Non-Vegetarian', 'Vegetarian', 'Eggetarian'];

  // final _auth = FirebaseAuth.instance;
  // FirebaseUser loggedInUser;
  //
  // _makePostRequest(String diet) async {
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
  //   String json = '{"userID": "${loggedInUser.uid}","diet": "$diet" }';
  //
  //   if (diet == "") {
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
  //         context, '/dashboard', (route) => false);
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
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
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
                'Select Your Diet',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500),
              )),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.50,
                margin: const EdgeInsets.only(top: 280.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: GestureDetector(
                            onTap: () {
                              print(items[index]);
                              //_makePostRequest(items[index]);
                              diet = items[index];
                              if (diet == '') {
                                _showErrorDialog('Please Select Your Diet');
                              } else {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/dashboard', (route) => false);
                                makePostRequest(
                                    finalw,
                                    finalbmi,
                                    finalheight,
                                    UserID,
                                    gender,
                                    aim,
                                    d_weight,
                                    dob,
                                    diet,
                                    context);
                              }
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0)),
                                elevation: 0.0,
                                color: colordesion(index),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 50.0),
                                      child: Text(
                                        items[index],
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    CircleAvatar(
                                      radius: 90.0,
                                      backgroundImage: AssetImage(
                                          'images/${items[index]}.jpeg'),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      )),
    );
  }
}

Color colordesion(int index) {
  if (index == 0)
    return Colors.redAccent[100];
  else if (index == 1)
    return Colors.greenAccent[100];
  else
    return Colors.yellowAccent[100];
}

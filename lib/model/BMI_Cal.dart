import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nutrical/model/meal_selection_helper.dart';
import 'package:nutrical/ui/profile.dart';

int weight = 0, wk = 0, wl = 0;
int height = 0;
bool isweight = true;

String finalw = '';
String finalbmi = '';
String finalheight = '';
String UserID = '';
String gender = '';
String aim = '';
String d_weight = '';
String dob = '';
String diet = '';

final _auth = FirebaseAuth.instance;

FirebaseUser loggedInUser;

double bmicalculation(int h, int w) {
  if (isweight) {
    finalw = w.toString();
    return w / (0.0001 * h * h);
  } else {
    finalw = (0.453592 * w).toString();
    return (0.453592 * w) / (0.0001 * h * h);
  }
}

String classes(double bmi) {
  if (bmi < 19)
    return 'Low BMI';
  else if (bmi >= 19 && bmi <= 24)
    return 'Normal';
  else if (bmi > 24 && bmi <= 29)
    return 'Overweight';
  else if (bmi > 30 && bmi <= 39)
    return 'Obesity';
  else if (bmi > 40) return 'Severe obesity';
}

void weightconvert(int w) {
  if (isweight) {
    wk = w;
    wl = (w * 2.20462).toInt();
  } else {
    wl = w;
    wk = (w * 0.453592).toInt();
  }
}

makePostRequest(finalw, finalbmi, finalheight, UserID, gender, aim, d_weight,
    dob, diet, context) async {
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

  // set up POST requtgest arguments
  // https://0bk1qflzja.execute-api.ap-south-1.amazonaws.com/v1/userid
  String url =
      'https://0bk1qflzja.execute-api.ap-south-1.amazonaws.com/v1/userid/${loggedInUser.uid}';
  Map<String, String> headers = {"Content-type": "application/json"};
  print(finalbmi);
  print(finalheight);
  print(UserID);
  print(gender);
  print(aim);
  print(d_weight);
  print(dob);
  print(diet);
  print(finalw);
  print(userID);

  String json =
      '{ "userID" : "${loggedInUser.uid}","height": "$finalheight","weight": "$finalw","d_weight": "$d_weight","gender": "$gender","aim":"$aim","diet": "$diet","dob": "$dob","bmi": "${finalbmi.toString().substring(0, 4)}"}';

  if (weight == "") {
    // _showErrorDialog('Please Fill all the fields');
  } else {
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print(statusCode);
    print(response.body);
    print(response.bodyBytes);
    // Navigator.pushNamedAndRemoveUntil(context,  '/your_height', (route) => false);
  }
}

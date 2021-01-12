import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';


makePostRequestforMeal(String UserID,String timestamp, String meal,String mealcalorie,String mealname,String mealweight,context) async{
  // set up POST requtgest arguments
  String url =
      'https://qmazsq3lvj.execute-api.ap-south-1.amazonaws.com/v2/userid/$UserID';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json =
      '{ "userID" : $UserID,"TimeStamp" : $timestamp, "Meal" : $meal,"MealCalorie": $mealcalorie,"MealName": $mealname,"MealWeight" : $mealweight}';


  if (UserID == "") {
    // _showErrorDialog('Please Fill all the fields');
  } else {
    Response response = await put(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print(body);
    print(statusCode);
    print(response.body);
    print(response.bodyBytes);
    print('DONE');
  }
}


String getCurrentTime(){
     final DateTime now = DateTime.now();
     final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted.toString(); // something like 2013-04-20
}

final _auth = FirebaseAuth.instance;

FirebaseUser loggedInUser;

getCurrentUser() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.uid);
      return loggedInUser.uid;
    }
  } catch (e) {
    print(e);
  }

}


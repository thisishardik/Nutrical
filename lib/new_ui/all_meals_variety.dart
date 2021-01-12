import 'dart:convert';

import 'package:custom_dialog/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:nutrical/new_ui/food_adding_db.dart';
import 'package:nutrical/ui/mealplan.dart';
import 'package:page_transition/page_transition.dart';

class AllMealsVarietyPage extends StatefulWidget {
  String foodItem;
  AllMealsVarietyPage({this.foodItem});

  @override
  _AllMealsVarietyPageState createState() => _AllMealsVarietyPageState();
}

class _AllMealsVarietyPageState extends State<AllMealsVarietyPage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  DateTime dateToday = DateTime.now();
  TimeOfDay timeToday = TimeOfDay.now();
  var ms = (new DateTime.now()).millisecondsSinceEpoch;
  int servings;

  makePostRequest(
    userID,
    TimeStamp,
    Meal,
    MealCalorie,
    MealName,
    MealWeight,
    Carbs,
    Protein,
    Fat,
  ) async {
    print(dateToday);
    Meal = "Dinner";
    if (timeToday.hour > 5 && timeToday.hour < 12) {
      Meal = "Breakfast";
    }
    if (timeToday.hour > 12 && timeToday.hour < 17) {
      Meal = "Lunch";
    }
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
        'https://qmazsq3lvj.execute-api.ap-south-1.amazonaws.com/V1AdNew/userid/abcd';
    Map<String, String> headers = {"Content-type": "application/json"};
    TimeStamp = '$dateToday';

    String json =
        '{ "userID" : "${loggedInUser.uid}","TimeStamp": "$dateToday","Meal": "$Meal","MealCalorie": $MealCalorie,"MealName": "$MealName","MealWeight":$MealWeight, "Carbs": "$Carbs", "Protein": "$Protein", "Fat": "$Fat"}';

    if (MealWeight == "") {
      // _showErrorDialog('Please Fill all the fields');
    } else {
      http.Response response =
          await http.post(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      String body = response.body;
      print(statusCode);
      print(response.body);
      print(response.bodyBytes);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MealPlan(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f3f8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
            'Choices in ${widget.foodItem.replaceFirst(widget.foodItem, widget.foodItem.substring(0, 1).toUpperCase() + widget.foodItem.substring(1).toLowerCase())}',
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: FutureBuilder(
          future: getapi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data['hints'].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 8.0, left: 10.0, right: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3.0,
                                    blurRadius: 5.0)
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    snapshot.data['hints'][index]['food']
                                                ['image'] ==
                                            null
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 75.0,
                                              width: 75.0,
                                              child: Center(
                                                child: Text(
                                                  'No preview available',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 75.0,
                                              width: 75.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "${snapshot.data['hints'][index]['food']['image']}",
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(height: 7.0),
                                    Text(
                                      "${snapshot.data['hints'][index]['food']['label'].replaceFirst(
                                        snapshot.data['hints'][index]['food']
                                            ['label'],
                                        snapshot.data['hints'][index]['food']
                                                    ['label']
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            snapshot.data['hints'][index]
                                                    ['food']['label']
                                                .substring(1)
                                                .toLowerCase(),
                                      )}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFCC8053),
                                        fontFamily: 'Varela',
                                        fontSize: 16.5,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                            color: Color(0xFFEBEBEB),
                                            height: 1.0)),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => Center(
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxHeight: 300.0,
                                            maxWidth: 250.0,
                                          ),
                                          child: Dialog(
                                            backgroundColor: Colors.white,
                                            insetAnimationDuration:
                                                Duration(milliseconds: 600),
                                            insetAnimationCurve: Curves.easeIn,
                                            insetPadding: EdgeInsets.symmetric(
                                              vertical: 15.0,
                                            ),
                                            elevation: 2.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'How many servings?',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Container(
                                                  height: 100.0,
                                                  width: 100,
                                                  child: CupertinoPicker(
                                                      backgroundColor:
                                                          Colors.white,
                                                      itemExtent: 32.0,
                                                      onSelectedItemChanged:
                                                          (selectedItem) {
                                                        servings = selectedItem
                                                            .toInt();
                                                        print(selectedItem);
                                                      },
                                                      children: [
                                                        Text("1"),
                                                        Text("2"),
                                                        Text("3"),
                                                        Text("4"),
                                                        Text("5"),
                                                      ]),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    makePostRequest(
                                                      '',
                                                      '',
                                                      'tatti',
                                                      snapshot.data['hints']
                                                                      [index]
                                                                  ['food']
                                                              ['nutrients']
                                                          ['ENERC_KCAL'],
                                                      '${snapshot.data['hints'][index]['food']['label']}',
                                                      servings,
                                                      '${snapshot.data['hints'][index]['food']['nutrients']['CHOCDF']}',
                                                      '${snapshot.data['hints'][index]['food']['nutrients']['PROCNT']}',
                                                      '${snapshot.data['hints'][index]['food']['nutrients']['FAT']}',
                                                    );
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 70.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0, bottom: 10.0),
                                      child: Center(
                                        child: Container(
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text('Add',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<Map> getapi() async {
    String api =
        'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=${widget.foodItem}&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34';

    http.Response response = await http.get(api);
    return json.decode(response.body);
  }
}

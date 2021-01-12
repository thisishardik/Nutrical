import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'dashboard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nutrical/model/bottomnav.dart' as bn;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart';

String food = '';

class MealSelection extends StatefulWidget {
  @override
  _MealSelectionState createState() => _MealSelectionState();
}

class _MealSelectionState extends State<MealSelection> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  DateTime dateToday = DateTime.now();
  TimeOfDay timeToday = TimeOfDay.now();
  var ms = (new DateTime.now()).millisecondsSinceEpoch;
  // String  Time  = (ms / 1000).round().toString();
  String mealWeight = '';
  makePostRequest(
      userID, TimeStamp, Meal, MealCalorie, MealName, MealWeight) async {
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
        'https://qmazsq3lvj.execute-api.ap-south-1.amazonaws.com/v2/userid/Anish';
    Map<String, String> headers = {"Content-type": "application/json"};
    TimeStamp = '$dateToday';

    String json =
        '{ "userID" : "${loggedInUser.uid}","TimeStamp": "$dateToday","Meal": "$Meal","MealCalorie": $MealCalorie,"MealName": "$MealName","MealWeight":"$MealWeight"}';

    if (MealWeight == "") {
      // _showErrorDialog('Please Fill all the fields');
    } else {
      Response response = await post(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      String body = response.body;
      print(statusCode);
      print(response.body);
      print(response.bodyBytes);
      Navigator.pushNamedAndRemoveUntil(
          context, '/meal_selection', (route) => false);
    }
  }

//  int _currentIndex = 2;
  Widget updateTemplate() {
    return FutureBuilder(
      future: getapi(),
      builder: (context, snapshot) {
        Map content = snapshot.data;
        return (snapshot.hasData)
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: content.length,
                itemBuilder: (context, index) {
                  return content['to'] > index
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 20.0,
                            bottom: 15.0,
                          ),
                          child: GFCard(
                            content: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.whatshot,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '${content['hits'][index]['recipe']['calories'].toStringAsFixed(1)} kcal',
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Alert(
                                          context: context,
                                          title: "Enter Quantity",
                                          content: Column(
                                            children: <Widget>[
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(Icons.fastfood),
                                                  labelText: 'Quantity',
                                                ),
                                                onChanged: (value) {
                                                  mealWeight = value;
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              onPressed: () async {
                                                makePostRequest(
                                                    '',
                                                    '',
                                                    '${content['hits'][index]['recipe']['label']}',
                                                    content['hits'][index]
                                                        ['recipe']['calories'],
                                                    '${content['hits'][index]['recipe']['label']}',
                                                    mealWeight);
                                              },
                                              child: Text(
                                                "ADD",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            )
                                          ]).show();
                                    },
                                    color: Colors.deepOrange,
                                    child: Center(
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            boxFit: BoxFit.cover,
                            elevation: 4.0,
                            titlePosition: GFPosition.start,
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10.0,
                              right: 10.0,
                              bottom: 20.0,
                            ),
                            margin: EdgeInsets.only(
                              left: 0.0,
                              right: 0.0,
                              top: 0.0,
                              bottom: 0.0,
                            ),
                            image: Image.network(
                              '${content['hits'][index]['recipe']['image']}',
                              fit: BoxFit.fitWidth,
                            ),
                            title: GFListTile(
                              title: Center(
                                child: Text(
                                  '${content['hits'][index]['recipe']['label']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container();

                  ///Old version
                  // ? Container(
                  //     margin: EdgeInsets.all(
                  //         MediaQuery.of(context).size.height / 44),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //         border: Border.all(
                  //             color: Colors.black45, width: 1.6)),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Container(
                  //           padding: EdgeInsets.all(8.0),
                  //           margin: EdgeInsets.only(
                  //               left:
                  //                   MediaQuery.of(context).size.height / 44,
                  //               right:
                  //                   MediaQuery.of(context).size.height / 44,
                  //               top:
                  //                   MediaQuery.of(context).size.height / 44,
                  //               bottom: MediaQuery.of(context).size.height /
                  //                   35),
                  //           height: MediaQuery.of(context).size.height / 5,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15.0),
                  //               border: Border.all(
                  //                   color: Colors.black45, width: 1.6)),
                  //           child: Image.network(
                  //             '${content['hits'][index]['recipe']['image']}',
                  //           ),
                  //         ),
                  //         Text(
                  //           '${content['hits'][index]['recipe']['label']}',
                  //           style: TextStyle(
                  //               fontSize: 14, fontWeight: FontWeight.w700),
                  //         ),
                  //         SizedBox(
                  //             height:
                  //                 MediaQuery.of(context).size.height / 44),
                  //         Container(
                  //           margin: EdgeInsets.symmetric(
                  //               horizontal:
                  //                   MediaQuery.of(context).size.width / 25),
                  //           child: Row(
                  //             children: <Widget>[
                  //               Image.asset(
                  //                 'images/fire.png',
                  //                 height: 20,
                  //                 width: 20,
                  //               ),
                  //               SizedBox(
                  //                   width:
                  //                       MediaQuery.of(context).size.width /
                  //                           50),
                  //               Text(
                  //                   '${content['hits'][index]['recipe']['calories'].toStringAsFixed(1)}',
                  //                   style: TextStyle(
                  //                       fontSize: 14.0,
                  //                       color: Colors.black54,
                  //                       fontWeight: FontWeight.w600)),
                  //               Spacer(),
                  //               Container(
                  //                 height:
                  //                     MediaQuery.of(context).size.height /
                  //                         44,
                  //                 width: MediaQuery.of(context).size.width /
                  //                     11,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.orange[800],
                  //                     borderRadius:
                  //                         BorderRadius.circular(10.0)),
                  //                 child: Center(
                  //                   child: GestureDetector(
                  //                     onTap: null,
                  //                     child: Text(
                  //                       'Add',
                  //                       style: TextStyle(
                  //                           fontSize: 11.0,
                  //                           color: Colors.white,
                  //                           fontWeight: FontWeight.w600),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   )
                  // : Container();
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Future<Map> getapi() async {
    // String api =
    //     'https://api.edamam.com/search?q=$food&app_id=75d5e385&app_key=33b2e0fb1a2bf76c6b927a16482e1cf2&from=0&to=3&calories=591-722&health=alcohol-free#';
    String api =
        'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=$food&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34';
    http.Response response = await http.get(api);
    return json.decode(response.body);
  }

//  void get() async {
//    Map data = await getapi();
//    print(data.toString());
//  }

  @override
  void initState() {
    super.initState();
    // get();
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
          'Meal Selection',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.2,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 18),
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(colors: [
              //       Colors.orange[900],
              //       Colors.orange,
              //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30.0),
              //       bottomRight: Radius.circular(30.0),
              //     ),
              //   ),
              //   height: MediaQuery.of(context).size.height / 6,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Text(
              //         'Meal Selection',
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 24.0,
              //             fontWeight: FontWeight.w600),
              //       ),
              //       CircleAvatar(
              //         backgroundColor: Colors.white,
              //         backgroundImage: AssetImage('images/bitemoji.jpg'),
              //         radius: 40.0,
              //       )
              //     ],
              //   ),
              // ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0).withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextField(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 18,
                    ),
                    hintText: "Search food items",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    food = value;
                  },
                ),
              ),
              // Container(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.only(
              //             left: 15.0,
              //             right: 20.0,
              //             top: 25.0,
              //             bottom: 20.0,
              //           ),
              //           child: Container(
              //             height: 50.5,
              //             child: TextField(
              //               onChanged: (value) {
              //                 food = value;
              //               },
              //               style: TextStyle(fontSize: 18.5),
              //               decoration: InputDecoration(
              //                 contentPadding:
              //                     EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
              //                 hintText: 'Search',
              //                 hintStyle: TextStyle(fontSize: 18.0),
              //                 prefixIcon: Icon(
              //                   Icons.search,
              //                   color: Colors.deepOrange,
              //                 ),
              //                 filled: true,
              //                 fillColor: Colors.white,
              //                 border: OutlineInputBorder(
              //                   borderSide: BorderSide(
              //                     color: Colors.black,
              //                     width: 1.2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(30.0),
              //                 ),
              //                 focusedBorder: OutlineInputBorder(
              //                   borderSide:
              //                       BorderSide(color: Colors.black, width: 1.3),
              //                   borderRadius: BorderRadius.circular(30.0),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              //         child: GestureDetector(
              //           onTap: () {
              //             //  Navigator.pushNamed(context, '/meal_plan');
              //           },
              //           child: Icon(
              //             Icons.short_text,
              //             color: Colors.deepOrange,
              //             size: 30.0,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              food == '' ? Container() : updateTemplate(),
            ],
          ),
        ),
      ),
    );
  }
}

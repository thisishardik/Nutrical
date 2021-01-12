import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/painting.dart';
import 'package:getwidget/getwidget.dart';

class FoodAddingDBPage extends StatefulWidget {
  String foodItem;
  FoodAddingDBPage({this.foodItem});

  @override
  _FoodAddingDBPageState createState() => _FoodAddingDBPageState();
}

class _FoodAddingDBPageState extends State<FoodAddingDBPage> {
  int dropdownValue = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: FutureBuilder(
            future: getapi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            margin: EdgeInsets.only(left: 40),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                  ),
                                ]),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Food Details",
                            style:
                                TextStyle(fontSize: 25, fontFamily: "Varela"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                            ),
                            Container(
                              child: Text(
                                'Pizza'
                                '',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Varela"),
                              ),
                            ),
                            Container(
                              child: Text(
                                '1200 kcal',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Varela"),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Center(
                                child: CircleAvatar(
                                  radius: 120,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(""),
                                  // backgroundImage:
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: 250,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8.0,
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 40),
                                  child: Text(
                                    "Servings",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Varela",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 40),
                                    child: DropdownButton<int>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 20,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      onChanged: (int newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <int>[
                                        1,
                                        2,
                                        3,
                                        4,
                                        5,
                                        6,
                                        7,
                                        8,
                                        10,
                                        11,
                                        12
                                      ].map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text("$value"),
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: GFProgressBar(
                                  percentage: 0.4,
                                  lineHeight: 6,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  leading: Container(
                                    width: 70,
                                    child: Text(
                                      "Carbs",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Varela",
                                          color: Colors.lightBlueAccent),
                                    ),
                                  ),
                                  backgroundColor: Colors.grey[200],
                                  progressBarColor: Colors.lightBlueAccent,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: GFProgressBar(
                                  percentage: 0.8,
                                  lineHeight: 6,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  leading: Center(
                                    child: Container(
                                      width: 70,
                                      child: Text(
                                        "Fat",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Varela",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.deepOrange),
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.grey[200],
                                  progressBarColor: Colors.deepOrange,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: GFProgressBar(
                                  percentage: 0.6,
                                  lineHeight: 6,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  leading: Container(
                                    width: 70,
                                    child: Text(
                                      "Protein",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Varela",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.deepPurple),
                                    ),
                                  ),
                                  backgroundColor: Colors.grey[200],
                                  progressBarColor: Colors.deepPurple,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return (Center(child: CircularProgressIndicator()));
              }
            }),
      ),
    );
  }

  Future<Map> getapi() async {
    String api =
        'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=${widget.foodItem}&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34';

    http.Response response = await http.get(api);
    return json.decode(response.body);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class ListYourWorkouts extends StatefulWidget {
  String level;
  ListYourWorkouts({this.level});
  @override
  _ListYourWorkoutsState createState() => _ListYourWorkoutsState();
}

class _ListYourWorkoutsState extends State<ListYourWorkouts> {
  SolidController _controller = SolidController();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  String bodyParts = "";
  String nameOfWorkout = "";
  String equipment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 190.0,
              floating: false,
              pinned: true,
              snap: false,
              backgroundColor: Color(0xFF31326f),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Lose weight",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.5,
                  ),
                ),
                background: Image.asset(
                  "images/sliver-fit-pic.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: getapi(widget.level),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Instruction',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Varela"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.level,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Varela"),
                                ),
                                Text(
                                  "Level",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Varela"),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pinkAccent,
                                    Colors.lightBlueAccent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "180",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Varela"),
                                ),
                                Text(
                                  "kCal",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Varela"),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pinkAccent,
                                    Colors.lightBlueAccent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "10 - 12 mins",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Varela"),
                                ),
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Varela"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data['Count'] - 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.lightBlueAccent,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(17)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data['Items'][index]
                                                    ['Name']['S'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          LikeButton(
                                            size: 30.0,
                                            circleColor: CircleColor(
                                                start: Color(0xff00ddff),
                                                end: Color(0xff0099cc)),
                                            bubblesColor: BubblesColor(
                                              dotPrimaryColor:
                                                  Color(0xff33b5e5),
                                              dotSecondaryColor:
                                                  Color(0xff0099cc),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return Icon(
                                                isLiked
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: isLiked
                                                    ? Colors.yellow
                                                    : Colors.white,
                                                size: 30.0,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2.0,
                                          right: 50.0,
                                          bottom: 10.0,
                                        ),
                                        child: Text(
                                          snapshot.data['Items'][index]
                                              ['Body_part']['S'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Equipment - ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'avenir',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                snapshot.data['Items'][index]
                                                    ['Equipment']['S'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'avenir',
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 30.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[700],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text('TRY',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              if (_controller.isOpened) {
                                                nameOfWorkout = "";
                                                bodyParts = "";
                                                equipment = "";
                                                _controller.hide();
                                              } else {
                                                nameOfWorkout =
                                                    snapshot.data['Items']
                                                        [index]['Name']['S'];
                                                bodyParts = snapshot
                                                        .data['Items'][index]
                                                    ['Body_part']['S'];
                                                equipment = snapshot
                                                        .data['Items'][index]
                                                    ['Equipment']['S'];
                                                _controller.show();
                                              }
                                              // _controller.isOpened
                                              //     ? _controller.hide()
                                              //     : _controller.show();
                                              //
                                              // nameOfWorkout =
                                              //     snapshot.data['Items'][index]
                                              //         ['Name']['S'];
                                              // bodyParts = snapshot.data['Items']
                                              //     [index]['Body_part']['S'];
                                              // equipment = snapshot.data['Items']
                                              //     [index]['Equipment']['S'];
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
        ),
      ),
      bottomSheet: SolidBottomSheet(
        controller: _controller,
        draggableBody: true,
        toggleVisibilityOnTap: false,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        smoothness: Smoothness.medium,
        body: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(30),
            //   topRight: Radius.circular(30),
            // ),
            color: Color(0xFFf1f3f8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Center(
                  child: Text(
                    "Animation",
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 7.5,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              SizedBox(height: 15.0),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://i.pinimg.com/originals/c4/15/13/c41513afb3abb500d59dfae4a5ebbf33.gif",
                    height: 150,
                    width: 200,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Center(
                child: Text(
                  "Gif Source: Spotebi.com",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.black,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "$nameOfWorkout",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Duration: 1:30 mins",
                      style: TextStyle(
                        fontFamily: 'Varela',
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Description: Pull up helps to build the shoulder muscles and it also enhance the torso muscles.",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Your body parts getting trained: $bodyParts",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Equipment needed for workout: $equipment",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///API
  Future<Map> getapi(String level) async {
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
    String api =
        'https://u7waim1mu0.execute-api.ap-south-1.amazonaws.com/v1/workindex/$level';

    http.Response response = await http.get(api);
    return json.decode(response.body);
  }
}

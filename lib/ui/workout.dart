import 'package:flutter/material.dart';
import 'package:nutrical/model/bottomnav.dart' as bn;

//yaml
//curved_navigation_bar: ^0.3.1
int _currentIndex = 3;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Workout(),
    );
  }
}

class Workout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bn.bottomnav(_currentIndex, context),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orange[900], Colors.orange],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 13,
                left: MediaQuery.of(context).size.width / 18,
                right: MediaQuery.of(context).size.width / 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Workout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w600),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('images/bitemoji.jpg'),
                  radius: 40.0,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4,
                left: MediaQuery.of(context).size.width / 18,
                right: MediaQuery.of(context).size.width / 18),
            child: TextField(
              style: TextStyle(fontSize: 23.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 23.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2),
                      borderRadius: BorderRadius.circular(25.0))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 280),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 35,
                    right: MediaQuery.of(context).size.width / 35,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1.1),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '90 mins',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            'images/running.png',
                            height: 70.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '475 kcal',
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 35,
                    right: MediaQuery.of(context).size.width / 35,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1.1),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '90 mins',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            'images/running.png',
                            height: 70.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '475 kcal',
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 35,
                    right: MediaQuery.of(context).size.width / 35,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1.1),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '90 mins',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            'images/running.png',
                            height: 70.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '475 kcal',
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 35,
                    right: MediaQuery.of(context).size.width / 35,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1.1),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '90 mins',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            'images/running.png',
                            height: 70.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '475 kcal',
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 35,
                    right: MediaQuery.of(context).size.width / 35,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1.1),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '90 mins',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            'images/running.png',
                            height: 70.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '475 kcal',
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 28,
                    left: MediaQuery.of(context).size.width / 35,
                    right: MediaQuery.of(context).size.width / 35,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1.1),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '90 mins',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                            'images/running.png',
                            height: 70.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '475 kcal',
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
//
//class AnimatedNavigatorBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return CurvedNavigationBar(
//      backgroundColor: Colors.white,
//      color: Colors.orange[200],
//      buttonBackgroundColor: Colors.orange[100],
//      height: MediaQuery.of(context).size.height / 17,
//      index: 2,
//      animationDuration: Duration(
//        milliseconds: 200,
//      ),
//      animationCurve: Curves.bounceInOut,
//      items: <Widget>[
//        Icon(Icons.home, size: 34, color: Colors.deepOrange),
//        Icon(Icons.directions_run, size: 34, color: Colors.deepOrange),
//        Icon(Icons.local_dining, size: 34, color: Colors.deepOrange),
//        Icon(Icons.fitness_center, size: 34, color: Colors.deepOrange),
//        Icon(Icons.person, size: 34, color: Colors.deepOrange),
//      ],
//    );
//  }
//}

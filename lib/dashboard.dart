import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math' as math;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nutrical/mealselection.dart';
import 'package:nutrical/new_ui/dinner_dash_card.dart';
import 'package:nutrical/new_ui/fintness_app_theme.dart';
import 'package:nutrical/new_ui/lunch_dash_card.dart';
import 'package:nutrical/new_ui/med_view.dart';
import 'package:nutrical/new_ui/breakfast_dash_card.dart';
import 'package:nutrical/new_ui/water_view.dart';
import 'package:nutrical/new_ui/workouts_intro.dart';
import 'package:nutrical/ui/exercise_subset.dart';
import 'package:nutrical/ui/mealplan.dart';
import 'package:nutrical/ui/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:wave_progress_widget/wave_progress_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrical/model/bottomnav.dart' as bn;
import 'package:http/http.dart' as http;
import 'package:pedometer/pedometer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.uid);
        return loggedInUser;
      }
    } catch (e) {
      print("ERROR IN loggedInUser : " + e);
    }
  }

  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'STANDING', _steps = '0';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    initPlatformState();
    totalCal = 0.0;
    foodItemsBreakfast = [];
    foodItemsLunch = [];
    foodItemsDinner = [];
    totalCalBreakfast = 0;
    totalCalLunch = 0;
    totalCalDinner = 0;
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  var _progressWaterLog = 0.0;

  String name = 'James';

  int burnedCal = 625;
  double totalCal;
  int consumedCal = 1200;
  List<String> foodItemsBreakfast;
  List<String> foodItemsLunch;
  List<String> foodItemsDinner;
  double totalCalBreakfast;
  double totalCalLunch;
  double totalCalDinner;
  bool showFloatingToast = false;
  int maxLength;
  int i;
  List<String> months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // void calTotalCalorie() async {
  //   String api =
  //       'https://qmazsq3lvj.execute-api.ap-south-1.amazonaws.com/v1Ad/userid/${loggedInUser.uid}';
  //
  //   http.Response response = await http.get(api);
  //   var snapshot =  json.decode(response.body);
  //
  // }

  // List<Widget> workoutlist = [
  //   WorkoutCards(activity: 'Running', cal: '125', time: '80'),
  //   WorkoutCards(activity: 'Weight Lifting', cal: '425', time: '30'),
  //   WorkoutCards(activity: 'Rope Skipping', cal: '250', time: '20'),
  //   WorkoutCards(activity: 'Running', cal: '125', time: '80'),
  //   WorkoutCards(activity: 'Rope Skipping', cal: '250', time: '20'),
  //   WorkoutCards(activity: 'Running', cal: '125', time: '80'),
  //   WorkoutCards(activity: 'Weight Lifting', cal: '425', time: '30'),
  // ];

  // _calculateTotalCal() async {
  //   for (i = 0;
  //   i <= 5;
  //   i = i + 1) {
  //     print("****");
  //     // totalCal = totalCal +
  //     //     double.parse(
  //     //         snapshot.data['Items'][i]['MealCalorie']['S']);
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f3f8),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(right: 0.0),
      //       child: PopupMenuButton<String>(
      //         icon: Icon(
      //           FontAwesomeIcons.ellipsisV,
      //           color: Colors.black,
      //           size: 15.5,
      //         ),
      //         onSelected: choiceAction,
      //         itemBuilder: (BuildContext context) {
      //           return Constants.choices.map((String choice) {
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Text(choice),
      //             );
      //           }).toList();
      //         },
      //       ),
      //     )
      //   ],
      //   // bottom: PreferredSize(
      //   //     preferredSize: Size(0.0, 45.0),
      //   //     child: Row(
      //   //       children: [
      //   //         Padding(
      //   //           padding: EdgeInsets.only(
      //   //             left: 15.0,
      //   //             bottom: 10.0,
      //   //           ),
      //   //           child: Text(
      //   //             'Welcome ${loggedInUser.displayName.substring(0, 1).toUpperCase()}${loggedInUser.displayName.substring(1, loggedInUser.displayName.length)}',
      //   //             style: TextStyle(
      //   //               fontSize: 18.5,
      //   //               fontWeight: FontWeight.w500,
      //   //               fontFamily: FitnessAppTheme.fontName,
      //   //               letterSpacing: 0.2,
      //   //               color: Colors.black,
      //   //             ),
      //   //           ),
      //   //         )
      //   //       ],
      //   //     )),
      //   title: Text(
      //     'Nutrical',
      //     style: TextStyle(
      //       fontWeight: FontWeight.w500,
      //       fontSize: 20,
      //       letterSpacing: 0.2,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'images/male.png',
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${loggedInUser.displayName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  // 'Feb 25, 2018',
                  '${months[DateTime.now().month - 1]} ${DateTime.now().day}, ${DateTime.now().year}',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: PopupMenuButton<String>(
              icon: Icon(
                FontAwesomeIcons.ellipsisV,
                color: Colors.black,
                size: 15.5,
              ),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          )
        ],
      ),
      body: GFFloatingWidget(
        verticalPosition: MediaQuery.of(context).size.height * 0.8,
        horizontalPosition: MediaQuery.of(context).size.width * 0.1,
        showblurness: showFloatingToast,
        blurnessColor: Colors.black54,
        child: showFloatingToast
            ? GFToast(
                backgroundColor: Colors.black,
                text: 'Add meals from the meal planner',
                type: GFToastType.rounded,
                textStyle: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                button: GFButton(
                  onPressed: () {
                    setState(() {
                      showFloatingToast = false;
                    });
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: MealPlan(),
                      ),
                    );
                  },
                  text: 'OK',
                  type: GFButtonType.transparent,
                  color: GFColors.SUCCESS,
                ),
                autoDismiss: false,
              )
            : Container(),
        body: RefreshIndicator(
          onRefresh: getapi,
          child: SpinCircleBottomBarHolder(
            bottomNavigationBar: SCBottomBarDetails(
                circleColors: [
                  Colors.white,
                  Colors.redAccent,
                  Colors.redAccent
                ],
                iconTheme: IconThemeData(color: Colors.redAccent),
                activeIconTheme: IconThemeData(color: Colors.redAccent),
                activeTitleStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                titleStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                actionButtonDetails: SCActionButtonDetails(
                    color: Colors.redAccent,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    elevation: 2),
                elevation: 2.0,
                items: [
                  // Suggested count : 4
                  SCBottomBarItem(
                      icon: Icons.home, title: "Home", onPressed: () {}),
                  SCBottomBarItem(
                      icon: FontAwesomeIcons.running,
                      title: "Workouts",
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: WorkoutsIntroPage(),
                          ),
                        );
                      }),
                  SCBottomBarItem(
                      icon: Icons.restaurant_outlined,
                      title: "Meals",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: MealPlan(),
                            ),
                            (route) => false);
                      }),
                  SCBottomBarItem(
                      icon: Icons.settings,
                      title: "Settings",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfilePage(),
                            ),
                            (route) => false);
                      }),
                ],
                circleItems: [
                  //Suggested Count: 3
                  SCItem(
                      icon: Icon(Icons.assignment_outlined),
                      onPressed: () {
                        setState(() {
                          showFloatingToast = true;
                        });
                      }),
                  SCItem(
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        setState(() {
                          showFloatingToast = true;
                        });
                      }),
                ],
                bnbHeight: 75 // Suggested Height 80
                ),
            child: FutureBuilder(
                future: getapi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (i = 0; i < snapshot.data['ScannedCount']; i = i + 1) {
                      print("****");
                      print(double.parse(
                              snapshot.data['Items'][i]['MealCalorie']['N'])
                          .runtimeType);
                      // print(snapshot.data['Items'][i]['MealCalorie']['S'] is int
                      //     ? "ANISH IS DEAD"
                      //     : "Hardik is happy");
                      totalCal += double.parse(
                          snapshot.data['Items'][i]['MealCalorie']['N']);

                      if (snapshot.data['Items'][i]['Meal']['S'] ==
                          'Breakfast') {
                        foodItemsBreakfast
                            .add(snapshot.data['Items'][i]['MealName']['S']);
                      } else if (snapshot.data['Items'][i]['Meal']['S'] ==
                          'Lunch') {
                        foodItemsLunch
                            .add(snapshot.data['Items'][i]['MealName']['S']);
                      } else if (snapshot.data['Items'][i]['Meal']['S'] ==
                          'Dinner') {
                        foodItemsDinner
                            .add(snapshot.data['Items'][i]['MealName']['S']);
                      }

                      if (snapshot.data['Items'][i]['Meal']['S'] ==
                          'Breakfast') {
                        totalCalBreakfast += double.parse(
                            snapshot.data['Items'][i]['MealCalorie']['N']);
                      } else if (snapshot.data['Items'][i]['Meal']['S'] ==
                          'Lunch') {
                        totalCalLunch += double.parse(
                            snapshot.data['Items'][i]['MealCalorie']['N']);
                      } else if (snapshot.data['Items'][i]['Meal']['S'] ==
                          'Dinner') {
                        totalCalDinner += double.parse(
                            snapshot.data['Items'][i]['MealCalorie']['N']);
                      }
                      print("$totalCal");
                      maxLength = math.max(
                          (math.max(foodItemsBreakfast.length,
                              foodItemsLunch.length)),
                          foodItemsDinner.length);
                      print("Max Length: $maxLength");
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Color(0xFFf2f3f8),
                          //     borderRadius: const BorderRadius.only(
                          //       bottomLeft: Radius.circular(32.0),
                          //     ),
                          //   ),
                          //   child: Column(
                          //     children: <Widget>[
                          //       SizedBox(
                          //         height: MediaQuery.of(context).padding.top,
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(
                          //             left: 16,
                          //             right: 16,
                          //             top: 16 - 8.0 * 0.2,
                          //             bottom: 0),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: <Widget>[
                          //             Expanded(
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Row(
                          //                   children: [
                          //                     Text(
                          //                       'Hi',
                          //                       textAlign: TextAlign.left,
                          //                       style: TextStyle(
                          //                         fontFamily:
                          //                             FitnessAppTheme.fontName,
                          //                         fontWeight: FontWeight.w700,
                          //                         fontSize: 23,
                          //                         letterSpacing: 1.0,
                          //                         color: FitnessAppTheme.darkerText,
                          //                       ),
                          //                     ),
                          //                     Padding(
                          //                       padding: const EdgeInsets.only(
                          //                           left: 8.0, right: 5.0),
                          //                       child: Text(
                          //                         '${loggedInUser.displayName.toUpperCase()}',
                          //                         textAlign: TextAlign.left,
                          //                         style: TextStyle(
                          //                           fontFamily:
                          //                               FitnessAppTheme.fontName,
                          //                           fontWeight: FontWeight.w700,
                          //                           fontSize: 20,
                          //                           letterSpacing: 1.0,
                          //                           color:
                          //                               FitnessAppTheme.darkerText,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //             // Padding(
                          //             //   padding: const EdgeInsets.only(
                          //             //     left: 8,
                          //             //     right: 8,
                          //             //   ),
                          //             //   child: Row(
                          //             //     children: <Widget>[
                          //             //       Text(
                          //             //         '${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}',
                          //             //         textAlign: TextAlign.left,
                          //             //         style: TextStyle(
                          //             //           fontFamily:
                          //             //               FitnessAppTheme.fontName,
                          //             //           fontWeight: FontWeight.normal,
                          //             //           fontSize: 18,
                          //             //           letterSpacing: -0.2,
                          //             //           color: FitnessAppTheme.darkerText,
                          //             //         ),
                          //             //       ),
                          //             //     ],
                          //             //   ),
                          //             // ),
                          //           ],
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              _steps,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 70,
                                fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Steps Walked'.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              letterSpacing: 0.0,
                              fontFamily: 'Varela',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${_steps} Steps'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '5000 Steps'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 8.0,
                                  percent: double.parse(_steps) / 5000,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  backgroundColor: Theme.of(context)
                                      .accentColor
                                      .withAlpha(30),
                                  progressColor: Colors.deepPurpleAccent,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Icon(
                                  _status == 'walking'
                                      ? Icons.directions_walk
                                      : _status == 'stopped'
                                          ? Icons.accessibility_new
                                          : Icons.accessibility_new_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Text(
                                    _status.toUpperCase(),
                                    style: _status == 'walking' ||
                                            _status == 'stopped'
                                        ? TextStyle(
                                            fontSize: 12,
                                            color: Colors.deepPurpleAccent,
                                            fontFamily: 'Varela',
                                          )
                                        : TextStyle(
                                            fontSize: 12,
                                            color: Colors.deepPurpleAccent,
                                            fontFamily: 'Varela',
                                          ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'DISTANCE',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: (double.parse(_steps) *
                                                        0.00142)
                                                    .ceilToDouble()
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' km',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'CALORIES',
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: (double.parse(_steps) *
                                                        0.04)
                                                    .ceilToDouble()
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' cal',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                              ],
                            ),
                          ),
                          MedView(
                            totalCalories: totalCal,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Container(
                            height: 200 + maxLength * 10.0,
                            child: ListView(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: BreakfastDashCard(
                                      title: 'Breakfast',
                                      // breakfastItems: foodItemsBreakfast,
                                      breakfastItems: foodItemsBreakfast,
                                      totalCalories: totalCalBreakfast),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: LunchDashCard(
                                    title: 'Lunch',
                                    // lunchItems: foodItemsLunch,
                                    lunchItems: foodItemsLunch,
                                    totalCalories: totalCalLunch,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: DinnerDashCard(
                                    title: 'Dinner',
                                    // dinnerItems: foodItemsDinner,
                                    dinnerItems: foodItemsDinner,
                                    totalCalories: totalCalDinner,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // BreakfastDashCard(
                          //   title: 'Breakfast',
                          //   breakfastItems: ["sds", "dfdfdf", "dfdfd"],
                          // ),
                          // LunchDashCard(
                          //   title: 'Lunch',
                          //   lunchItems: ["sds", "dfdfdf", "dfdfd"],
                          // ),
                          Waterview(),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return (Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                }),
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Notices) {
      print('Notices');
    } else if (choice == Constants.Contact) {
      print('Subscribe');
    } else if (choice == Constants.SignOut) {
      print('SignOut');
    }
  }

  Future<Map> getProfileAPI() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        userID = loggedInUser.uid;
        print(loggedInUser.uid);
        name = loggedInUser.displayName;
        print(loggedInUser.displayName);
        email = loggedInUser.email;
        print(loggedInUser.email);
        print(loggedInUser.photoUrl);
        print(userID);
        String api =
            'https://419kmxl3nc.execute-api.ap-south-1.amazonaws.com/v1Ad/userid/$userID';
        http.Response response = await http.get(api);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map> getapi() async {
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
        'https://qmazsq3lvj.execute-api.ap-south-1.amazonaws.com/v1Ad/userid/${loggedInUser.uid}';

    http.Response response = await http.get(api);
    return json.decode(response.body);
  }
}

class Constants {
  static const String Contact = 'Contact us';
  static const String Notices = 'Notices';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[Contact, Notices, SignOut];
}

// class WeekStrip extends StatelessWidget {
//   Color func(int day) {
//     DateTime date = DateTime.now();
//     if (date.weekday == day) {
//       return Colors.deepOrange;
//     } else {
//       return Colors.black;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Text(
//           'Mon',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(1)),
//         ),
//         Text(
//           'Tue',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(2)),
//         ),
//         Text(
//           'Wed',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(3)),
//         ),
//         Text(
//           'Thu',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(4)),
//         ),
//         Text(
//           'Fri',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(5)),
//         ),
//         Text(
//           'Sat',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(6)),
//         ),
//         Text(
//           'Sun',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w600, color: func(7)),
//         ),
//       ],
//     );
//   }
// }
//
// class MealTimingCard extends StatelessWidget {
//   MealTimingCard({this.whichMeal, this.timing, this.food, this.backcolor});
//
//   final String whichMeal;
//   final String timing;
//   final String food;
//   final Color backcolor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       height: MediaQuery.of(context).size.height / 5.5,
//       child: Row(
//         children: <Widget>[
//           Container(
// //            color: Colors.red,
//             height: MediaQuery.of(context).size.height / 6,
//             width: MediaQuery.of(context).size.width / 3.5,
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 Text(
//                   '$whichMeal',
//                   style: TextStyle(fontSize: 20.0, color: Colors.grey),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 17),
//                 Text(
//                   '$timing',
//                   style: TextStyle(fontSize: 20.0, color: Colors.grey),
//                 )
//               ],
//             ),
//           ),
//           Container(
// //            color: Colors.yellow,
//             height: MediaQuery.of(context).size.height / 6,
//             width: MediaQuery.of(context).size.width / 1.4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: MediaQuery.of(context).size.height / 35),
//                 Container(
//                   height: 1.5,
//                   width: MediaQuery.of(context).size.width / 1.4,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 20),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: MediaQuery.of(context).size.height / 40,
//                     horizontal: MediaQuery.of(context).size.width / 20,
//                   ),
//                   height: MediaQuery.of(context).size.height / 12,
//                   width: MediaQuery.of(context).size.width / 1.6,
//                   decoration: BoxDecoration(
//                       color: backcolor,
//                       borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                   child: Text(
//                     '$food',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class WorkoutCards extends StatelessWidget {
//   WorkoutCards({this.activity, this.time, this.cal});
//   final String activity;
//   final String time;
//   final String cal;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12.0),
//       margin: EdgeInsets.all(20.0),
//       height: double.infinity,
//       width: MediaQuery.of(context).size.width / 2.6,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//         gradient: LinearGradient(colors: [
//           Color(0xFFF07030),
//           Color(0xFFED8F2F),
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//       ),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Text(
//                 '$activity',
//                 style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w800),
//               )
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               Text(
//                 '$time mins',
//                 style: TextStyle(color: Colors.white),
//               )
//             ],
//           ),
//           Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Text(
//                 '$cal kcal',
//                 style: TextStyle(color: Colors.white, fontSize: 19),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// FutureBuilder(
// future: getCurrentUser(),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// return SingleChildScrollView(
// child: Column(
// children: <Widget>[
// MealTimingCard(
// whichMeal: 'Breakfast',
// timing: '8.00',
// food: 'Avacado heaven',
// backcolor: Color(0xFFCEF9BA),
// ),
// MealTimingCard(
// whichMeal: 'Lunch',
// timing: '12.00',
// food: 'Grilled chicken',
// backcolor: Color(0xFFFCD0BF),
// ),
// MealTimingCard(
// whichMeal: 'Dinner',
// timing: '8.00',
// food: 'Grilled Potato',
// backcolor: Color(0xFFEDCCEB),
// ),
// Container(
// margin: EdgeInsets.symmetric(
// vertical: MediaQuery.of(context).size.height / 60,
// horizontal: MediaQuery.of(context).size.width / 20),
// child: Row(
// children: <Widget>[
// Text(
// 'Workout',
// style: TextStyle(
// fontSize: 20.0, fontWeight: FontWeight.w600),
// ),
// Spacer(),
// FlatButton(
// onPressed: null,
// child: Container(
// child: Center(
// child: Text(
// 'View More',
// style: TextStyle(color: Colors.white),
// textAlign: TextAlign.center,
// ),
// ),
// height: 20.0,
// width: 100.0,
// decoration: BoxDecoration(
// color: Colors.deepOrange,
// borderRadius: BorderRadius.circular(10.0)),
// ),
// )
// ],
// ),
// ),
// Container(
// //                color: Colors.yellow,
// height: MediaQuery.of(context).size.height / 5,
// width: double.infinity,
// child: ListView(
// scrollDirection: Axis.horizontal,
// children: workoutlist,
// ),
// ),
// Container(
// margin: EdgeInsets.symmetric(
// vertical: MediaQuery.of(context).size.height / 40,
// horizontal: MediaQuery.of(context).size.width / 20),
// child: Row(
// children: <Widget>[
// Text(
// 'Water Intake',
// style: TextStyle(
// fontSize: 20.0, fontWeight: FontWeight.w600),
// ),
// ],
// ),
// ),
// Container(
// height: MediaQuery.of(context).size.height / 3.5,
// width: double.infinity,
// child: Column(
// children: <Widget>[
// SizedBox(
// height: MediaQuery.of(context).size.height / 40),
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: <Widget>[
// WaveProgress(160.0, Colors.blue, Colors.lightBlue,
// _progressWaterLog),
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// GestureDetector(
// onTap: () {
// setState(() {
// if (_progressWaterLog < 100) {
// _progressWaterLog =
// _progressWaterLog + 10;
// }
// });
// },
// child: Container(
// height: 40.0,
// width: 40.0,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.blue),
// child: Icon(
// FontAwesomeIcons.plus,
// color: Colors.white,
// ),
// ),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 40,
// ),
// GestureDetector(
// onTap: () {
// setState(() {
// if (_progressWaterLog > 0) {
// _progressWaterLog =
// _progressWaterLog - 10;
// }
// });
// },
// child: Container(
// height: 40.0,
// width: 40.0,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.blue),
// child: Icon(
// FontAwesomeIcons.minus,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// Column(
// children: <Widget>[
// Text(
// 'You have consumed',
// style: TextStyle(
// color: Colors.blueAccent,
// fontSize: 18.0,
// fontWeight: FontWeight.w700),
// ),
// Text(
// '${_progressWaterLog.round() * 20} ml',
// style: TextStyle(
// color: Colors.blueAccent,
// fontSize: 30.0,
// fontWeight: FontWeight.w700),
// ),
// ],
// )
// ],
// ),
// ],
// ),
// ),
// GestureDetector(
// onTap: () {
// Navigator.pushNamed(context, '/steptracker');
// },
// child: Container(
// height: 100,
// width: double.infinity,
// margin: EdgeInsets.all(8),
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.grey[300],
// blurRadius: 3.0, // soften the shadow
// spreadRadius: 3.0, //extend the shadow
// offset: Offset(
// 1.0, // Move to right 10  horizontally
// 2.0, // Move to bottom 5 Vertically
// ),
// ),
// ],
// borderRadius: BorderRadius.circular(10),
// ),
// child: Row(
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 25),
// child: Text(
// 'Step Tracker',
// style: TextStyle(
// fontSize: 30,
// color: Colors.deepOrangeAccent),
// ),
// ),
// Spacer(),
// Container(
// decoration: BoxDecoration(
// color: Colors.deepOrangeAccent[100],
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(10),
// bottomRight: Radius.circular(10))),
// width: 120,
// height: double.infinity,
// child: Icon(
// Icons.directions_run,
// size: 50,
// ))
// ],
// )),
// ),
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.03,
// ),
// GestureDetector(
// onTap: () {
// Navigator.pushNamed(context, '/sleeptracker');
// },
// child: Container(
// height: 100,
// width: double.infinity,
// margin: EdgeInsets.all(8),
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.grey[300],
// blurRadius: 3.0, // soften the shadow
// spreadRadius: 3.0, //extend the shadow
// offset: Offset(
// 1.0, // Move to right 10  horizontally
// 2.0, // Move to bottom 5 Vertically
// ),
// ),
// ],
// borderRadius: BorderRadius.circular(10),
// ),
// child: Row(
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 25),
// child: Text(
// 'Sleep Tracker',
// style: TextStyle(
// fontSize: 30,
// color: Colors.deepOrangeAccent),
// ),
// ),
// Spacer(),
// Container(
// decoration: BoxDecoration(
// color: Colors.deepOrangeAccent[100],
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(10),
// bottomRight: Radius.circular(10))),
// width: 120,
// height: double.infinity,
// child: Icon(
// Icons.airline_seat_individual_suite,
// size: 50,
// ))
// ],
// )),
// ),
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.06,
// ),
// ],
// ),
// );
// } else {
// return Center(child: Text('Loading...'));
// }
// },
// ),

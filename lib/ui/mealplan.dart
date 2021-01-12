import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutrical/dashboard.dart';
import 'package:nutrical/model/BMI_Cal.dart';
import 'package:nutrical/model/bottomnav.dart' as bn;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nutrical/new_ui/fintness_app_theme.dart';
import 'file:///F:/Android/AndroidStudioProjects/nutrical_new/lib/new_ui/networking/food_model.dart';
import 'package:nutrical/new_ui/meal_search_page.dart';
import 'package:nutrical/new_ui/networking/new_food_search_delegate.dart';
import 'file:///F:/Android/AndroidStudioProjects/nutrical_new/lib/new_ui/networking/search_food_git.dart';
import 'package:nutrical/new_ui/workouts_intro.dart';
import 'package:nutrical/ui/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

//PickedFile imageFile;
//File imgFile;
//final ImagePicker _picker = ImagePicker();
int _currentIndex = 2;

class MealPlan extends StatefulWidget {
  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
//  _openGallery() async {
//    var picture = await _picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      imageFile = picture;
//      imgFile = File(imageFile.path);
//      // imgFile = imageFile.path
//    });
//    //Navigator.of(context).pop();
//  }

//  _openCamera() async {
//    var picture = await _picker.getImage(source: ImageSource.camera);
//    setState(() {
//      imageFile = picture;
//      imgFile = File(imageFile.path);
//    });
//    // Navigator.of(context).pop();
//  }
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  double height = 150.0;
  List<String> foodItems = [];
  int countB;
  int countL;
  int countD;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose From'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: FlatButton.icon(
                      onPressed: null, //_openGallery()
                      icon: Icon(
                        Icons.camera_roll,
                        color: Colors.red,
                      ),
                      label: Text('Gallery'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: FlatButton.icon(
//                      onPressed: () => _openCamera(),
                      icon: Icon(Icons.camera_front, color: Colors.blue),
                      label: Text('Camera'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future buildFoodItemsList() async {
    FoodModel foodModel = FoodModel();
    var foodData = await foodModel.getFoodDetails('pasta');
    for (var i = 0; i < 5; i++) {
      foodItems.add(foodData['hints'][i]['food']['label']
          .toString()
          .replaceFirst(
              foodData['hints'][i]['food']['label'],
              foodData['hints'][i]['food']['label']
                      .toString()
                      .substring(0, 1)
                      .toUpperCase() +
                  foodData['hints'][i]['food']['label']
                      .toString()
                      .substring(1)
                      .toLowerCase()));
    }
  }

  @override
  void initState() {
    super.initState();
    buildFoodItemsList();
    countB = 0;
    countL = 0;
    countD = 0;
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 25.5),
      backgroundColor: Colors.orange,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.camera, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('Camera'),
          label: 'Camera',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => Navigator.pushNamed(context, '/meal_selection'),
          label: 'Search from list',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          labelBackgroundColor: Colors.blue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFf2f3f8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: null,
          title: Text(
            'Meal Planner',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              letterSpacing: 0.2,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            /// Add three dots icon
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
                      icon: Icons.home,
                      title: "Home",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Dashboard(),
                            ),
                            (route) => false);
                      }),
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
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: MealPlan(),
                          ),
                        );
                      }),
                  SCBottomBarItem(
                      icon: Icons.settings,
                      title: "Settings",
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: ProfilePage(),
                          ),
                        );
                      }),
                ],
                circleItems: [
                  //Suggested Count: 3
                  SCItem(
                      icon: Icon(Icons.assignment_outlined),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.fade,
                        //         child: SearchListViewExample()));
                        // Navigator.pushNamed(context, '/meal_selection');
                        // showSearch(
                        //     context: context,
                        //     delegate: DataSearch(foodList: foodItems));
                        showSearch(
                            context: context,
                            delegate: FoodSearchDelegate(foodList: foodItems));
                      }),
                  SCItem(
                      icon: Icon(Icons.camera_alt_outlined), onPressed: () {}),
                ],
                bnbHeight: 75 // Suggested Height 80
                ),
            child: FutureBuilder(
              future: getapi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  /// brkfast lunch dinner counter
                  for (var i = 0; i < snapshot.data['ScannedCount']; i++) {
                    if (snapshot.data['Items'][i]['Meal']['S'] == 'Breakfast') {
                      countB += 1;
                    } else if (snapshot.data['Items'][i]['Meal']['S'] ==
                        'Lunch') {
                      countL += 1;
                    } else if (snapshot.data['Items'][i]['Meal']['S'] ==
                        'Dinner') {
                      countD += 1;
                    }
                  }
                  return SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: MediaQuery.of(context).size.width / 18),
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [Colors.orange[900], Colors.orange],
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //     ),
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
                        //         'Meal Plan',
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 30.0,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       CircleAvatar(
                        //         backgroundColor: Colors.white,
                        //         backgroundImage:
                        //             AssetImage('images/bitemoji.jpg'),
                        //         radius: 40.0,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          child: CalendarStripe(),
                        ),
                        MealInfo(
                          time: 'BREAKFAST',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        countB != 0
                            ? SizedBox(
                                height: 230.0,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data['ScannedCount'],
                                    itemBuilder: (context, index) {
                                      print(snapshot.data.length);
                                      return snapshot.data['Items'][index]
                                                  ['Meal']['S'] ==
                                              'Breakfast'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: FlipCard(
                                                  direction: FlipDirection
                                                      .HORIZONTAL, // default
                                                  front: Card(
                                                    elevation: 2.0,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                        10.0,
                                                        10.0,
                                                        10.0,
                                                        5.0,
                                                      ),
                                                      // width: 200.0,
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 250.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.black38,
                                                            width: 1.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                            'images/food.jpg',
                                                            fit: BoxFit.contain,
                                                          ),
                                                          Text(
                                                            "${snapshot.data['Items'][index]['MealName']['S'].toString().replaceFirst(
                                                                  snapshot.data[
                                                                              'Items']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'MealName']['S'],
                                                                  snapshot.data[
                                                                              'Items']
                                                                              [
                                                                              index]
                                                                              [
                                                                              'MealName']
                                                                              [
                                                                              'S']
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              1)
                                                                          .toUpperCase() +
                                                                      snapshot
                                                                          .data[
                                                                              'Items']
                                                                              [
                                                                              index]
                                                                              [
                                                                              'MealName']
                                                                              [
                                                                              'S']
                                                                          .toString()
                                                                          .substring(
                                                                              1)
                                                                          .toLowerCase(),
                                                                )}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 16.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  back: Card(
                                                    elevation: 2.0,
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 250.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black38,
                                                          width: 1.1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 20.0,
                                                          left: 15.0,
                                                          right: 15.0,
                                                          bottom: 15.0,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              "${snapshot.data['Items'][index]['MealName']['S']}",
                                                              style: TextStyle(
                                                                fontSize: 20.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 8.0),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 10.0,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Calories:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Text(
                                                                    "${snapshot.data['Items'][index]['MealCalorie']['N']} kcal",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Servings:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Text(
                                                                    "${snapshot.data['Items'][index]['MealWeight']['N']} kg",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Carbs:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Text(
                                                                    "${snapshot.data['Items'][index]['Carbs']['S']} kcal",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Proteins:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Text(
                                                                    "${snapshot.data['Items'][index]['Protein']['S']}%",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Fats:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Text(
                                                                    "${snapshot.data['Items'][index]['Fat']['N']}%",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            )
                                          : Container();
                                    }),
                              )
                            : Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'No meals added',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15.5,
                                  ),
                                ),
                              ),
                        MealInfo(
                          time: 'LUNCH',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        countL != 0
                            ? SizedBox(
                                height: 230.0,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data['ScannedCount'],
                                    itemBuilder: (context, index) {
                                      print(snapshot.data.length);
                                      return snapshot.data['Items'][index]
                                                  ['Meal']['S'] ==
                                              'Lunch'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: FlipCard(
                                                  direction: FlipDirection
                                                      .HORIZONTAL, // default
                                                  front: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                      10.0,
                                                      10.0,
                                                      10.0,
                                                      5.0,
                                                    ),
                                                    // width: 200.0,
                                                    constraints: BoxConstraints(
                                                      maxWidth: 250.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black38,
                                                          width: 1.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'images/food.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                        Text(
                                                          "${snapshot.data['Items'][index]['MealName']['S'].toString().replaceFirst(
                                                                snapshot.data[
                                                                            'Items']
                                                                        [index][
                                                                    'MealName']['S'],
                                                                snapshot.data[
                                                                            'Items']
                                                                            [
                                                                            index]
                                                                            [
                                                                            'MealName']
                                                                            [
                                                                            'S']
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            1)
                                                                        .toUpperCase() +
                                                                    snapshot
                                                                        .data[
                                                                            'Items']
                                                                            [
                                                                            index]
                                                                            [
                                                                            'MealName']
                                                                            [
                                                                            'S']
                                                                        .toString()
                                                                        .substring(
                                                                            1)
                                                                        .toLowerCase(),
                                                              )}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  back: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 250.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black38,
                                                        width: 1.1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                        left: 15.0,
                                                        right: 15.0,
                                                        bottom: 15.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "${snapshot.data['Items'][index]['MealName']['S']}",
                                                            style: TextStyle(
                                                              fontSize: 20.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 10.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Calories:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['MealCalorie']['N']} kcal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Servings:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['MealWeight']['N']} kg",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Carbs:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['Carbs']['S']}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Proteins:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['Protein']['S']}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Fats:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['Fat']['S']}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            )
                                          : Container();
                                    }),
                              )
                            : Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'No meals added',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15.5,
                                  ),
                                ),
                              ),
                        MealInfo(
                          time: 'DINNER',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        countD != 0
                            ? SizedBox(
                                height: 230.0,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data['ScannedCount'],
                                    itemBuilder: (context, index) {
                                      print(snapshot.data.length);
                                      return snapshot.data['Items'][index]
                                                  ['Meal']['S'] ==
                                              'Dinner'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: FlipCard(
                                                  direction: FlipDirection
                                                      .HORIZONTAL, // default
                                                  front: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                      10.0,
                                                      10.0,
                                                      10.0,
                                                      5.0,
                                                    ),
                                                    // width: 200.0,
                                                    constraints: BoxConstraints(
                                                      maxWidth: 250.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black38,
                                                          width: 1.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'images/food.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                        Text(
                                                          "${snapshot.data['Items'][index]['MealName']['S'].toString().replaceFirst(
                                                                snapshot.data[
                                                                            'Items']
                                                                        [index][
                                                                    'MealName']['S'],
                                                                snapshot.data[
                                                                            'Items']
                                                                            [
                                                                            index]
                                                                            [
                                                                            'MealName']
                                                                            [
                                                                            'S']
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            1)
                                                                        .toUpperCase() +
                                                                    snapshot
                                                                        .data[
                                                                            'Items']
                                                                            [
                                                                            index]
                                                                            [
                                                                            'MealName']
                                                                            [
                                                                            'S']
                                                                        .toString()
                                                                        .substring(
                                                                            1)
                                                                        .toLowerCase(),
                                                              )}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  back: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 250.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black38,
                                                        width: 1.1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                        left: 15.0,
                                                        right: 15.0,
                                                        bottom: 15.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            "${snapshot.data['Items'][index]['MealName']['S']}",
                                                            style: TextStyle(
                                                              fontSize: 20.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 10.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Calories:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['MealCalorie']['N']} kcal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Servings:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['MealWeight']['N']} kg",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Carbs:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['Carbs']['S']} kcal",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Proteins:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['Protein']['S']}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Fats:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                  "${snapshot.data['Items'][index]['Fat']['S']}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            )
                                          : Container();
                                    }),
                              )
                            : Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'No meals added',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15.5,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 50.0,
                        ),
                        // MealInfo(
                        //   time: 'LUNCH',
                        // ),
                        // ListView.builder(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: snapshot.data.length,
                        //     itemBuilder: (context, index) {
                        //       return Row(
                        //         children: <Widget>[
                        //           Container(
                        //               height:
                        //                   MediaQuery.of(context).size.height / 11,
                        //               width: MediaQuery.of(context).size.width / 6,
                        //               decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     color: Colors.black38, width: 1.1),
                        //                 borderRadius: BorderRadius.circular(15.0),
                        //               ),
                        //               child: Image.asset(
                        //                 'images/bowl.png',
                        //                 fit: BoxFit.contain,
                        //               )),
                        //           SizedBox(
                        //               width:
                        //                   MediaQuery.of(context).size.width / 15),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Text(
                        //                 'name',
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.w600),
                        //               ),
                        //               SizedBox(
                        //                   height:
                        //                       MediaQuery.of(context).size.height /
                        //                           86),
                        //               Row(
                        //                 children: <Widget>[
                        //                   Icon(
                        //                     Icons.whatshot,
                        //                     color: Colors.deepOrange,
                        //                   ),
                        //                   SizedBox(
                        //                       width: MediaQuery.of(context)
                        //                               .size
                        //                               .width /
                        //                           50),
                        //                   Text(
                        //                     'cal',
                        //                     style: TextStyle(
                        //                         fontSize: 17.0,
                        //                         fontWeight: FontWeight.w600),
                        //                   )
                        //                 ],
                        //               )
                        //             ],
                        //           )
                        //         ],
                        //       );
                        //     }),
                        // MealInfo(
                        //   time: 'DINNER',
                        // ),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: snapshot.data.length,
                        //     itemBuilder: (context, index) {
                        //       return Row(
                        //         children: <Widget>[
                        //           Container(
                        //               height:
                        //                   MediaQuery.of(context).size.height / 11,
                        //               width: MediaQuery.of(context).size.width / 6,
                        //               decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     color: Colors.black38, width: 1.1),
                        //                 borderRadius: BorderRadius.circular(15.0),
                        //               ),
                        //               child: Image.asset(
                        //                 'images/bowl.png',
                        //                 fit: BoxFit.contain,
                        //               )),
                        //           SizedBox(
                        //               width:
                        //                   MediaQuery.of(context).size.width / 15),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Text(
                        //                 'name',
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.w600),
                        //               ),
                        //               SizedBox(
                        //                   height:
                        //                       MediaQuery.of(context).size.height /
                        //                           86),
                        //               Row(
                        //                 children: <Widget>[
                        //                   Icon(
                        //                     Icons.whatshot,
                        //                     color: Colors.deepOrange,
                        //                   ),
                        //                   SizedBox(
                        //                       width: MediaQuery.of(context)
                        //                               .size
                        //                               .width /
                        //                           50),
                        //                   Text(
                        //                     'cal',
                        //                     style: TextStyle(
                        //                         fontSize: 17.0,
                        //                         fontWeight: FontWeight.w600),
                        //                   )
                        //                 ],
                        //               )
                        //             ],
                        //           )
                        //         ],
                        //       );
                        //     }),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
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

class MealInfo extends StatelessWidget {
  MealInfo({
    this.time,
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 18,
        right: MediaQuery.of(context).size.width / 18,
      ),
      // height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '$time',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45),
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}

class CalendarStripe extends StatelessWidget {
  DateTime startDate = DateTime.now().subtract(Duration(days: 365));
  DateTime endDate = DateTime.now().add(Duration(days: 365));
  DateTime selectedDate = DateTime.now();

  List<DateTime> markedDates = [DateTime.now()];

  onSelect(data) {
    print("Selected Date -> ${data}");

    /// Call the api to display results for the selected date.
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      padding: EdgeInsets.only(top: 9, bottom: 6),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(top: 8, left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      ),
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;

    TextStyle normalStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black38);

    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);

    TextStyle dayNameStyle = TextStyle(
      fontSize: 15,
      color: isSelectedDate ? Colors.black87 : Colors.black38,
      fontWeight: FontWeight.w600,
    );

    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      SizedBox(
        height: 15.0,
      ),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CalendarStrip(
      startDate: startDate,
      endDate: endDate,
      onDateSelected: onSelect,
      dateTileBuilder: dateTileBuilder,
      iconColor: Colors.black87,
      monthNameWidget: _monthNameWidget,
      markedDates: markedDates,
      containerDecoration: BoxDecoration(color: Colors.black12),
      addSwipeGesture: true,
    );
  }
}

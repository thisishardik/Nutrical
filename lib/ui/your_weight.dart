import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:nutrical/model/BMI_Cal.dart' as bmical;
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Your_Weight extends StatefulWidget {
  @override
  _Your_WeightState createState() => _Your_WeightState();
}

class _Your_WeightState extends State<Your_Weight> {
  DateTime _dateTime;
  String dob = 'Date';
  double weight = 0.0;

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
      print(e);
    }
  }

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
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
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60.0, left: 30.0, right: 30.0),
                      child: Text(
                        'Weight',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60.0, left: 30.0, right: 30.0),
                      child: Text(
                        'We will make sure you get better',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0),
                      child: Text(
                        ' and personalized results',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            bmical.isweight = true;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: bmical.isweight
                                ? Color(0xFFF07030)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              'Kg',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: bmical.isweight
                                    ? Colors.white
                                    : Colors.black,
                                // decoration: (bmical.isweight)
                                //     ? TextDecoration.underline
                                //     : null
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 0.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            bmical.isweight = false;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: bmical.isweight
                                ? Colors.white
                                : Color(0xFFF07030),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              'lb',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: bmical.isweight
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70.0),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                size: 25.0,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: _dateTime == null
                                            ? DateTime.now()
                                            : _dateTime,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(3000))
                                    .then((date) {
                                  setState(() {
                                    _dateTime = date;
                                    dob = _dateTime.toString().substring(0, 11);
                                    bmical.dob = dob;
                                  });
                                });
                              },
                            ),
                          ),
                          Text(
                            dob,
                            style: TextStyle(
                                fontSize: 15.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              // weights is kgs or lbs
              (bmical.isweight)
                  ? Container(
                      margin: EdgeInsets.all(30.0),
                      child: FluidSlider(
                        value: weight,
                        onChanged: (double newValue) {
                          setState(() {
                            weight = newValue;
                            bmical.weight = newValue.round();
                          });
                        },
                        min: 0.0,
                        max: 100.0,
                        sliderColor: Colors.orange,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(30.0),
                      child: FluidSlider(
                        value: weight,
                        onChanged: (newValue) {
                          setState(() {
                            weight = newValue;
                            bmical.weight = newValue.round();
                          });
                        },
                        min: 0.0,
                        max: 220.0,
                        sliderColor: Colors.orange,
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  print(bmical.weight);
                  bmical.weightconvert(bmical.weight);
                  if (bmical.weight == '' || bmical.dob == '') {
                    _showErrorDialog('Please Fill It');
                  } else
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/your_height', (route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 45.0,
                      ),
                    ),
                  ),
                ),
              ),
              // FloatingActionButton(
              //   backgroundColor: Colors.orange,
              //   onPressed: () {
              //     print(bmical.weight);
              //     bmical.weightconvert(bmical.weight);
              //     if (bmical.weight == '' || bmical.dob == '') {
              //       _showErrorDialog('Please Fill It');
              //     } else
              //       Navigator.pushNamedAndRemoveUntil(
              //           context, '/your_height', (route) => false);
              //   },
              //   child: Icon(
              //     Icons.chevron_right,
              //     color: Colors.white,
              //     size: 25.0,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

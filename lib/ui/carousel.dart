// This section contain all the carousel.

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:nutrical/ui/gender.dart';
import 'package:nutrical/utilities.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffa6f6f1),
              Color(0xFF41aea9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //SizedBox(height: MediaQuery.of(context).size.height / 10.2),
              Container(
                padding: EdgeInsets.all(50.0),
                child: Card(
                  child: CircleAvatar(
                    radius: 130.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(128),
                      child: Image.asset('images/girlfitness.jpeg'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  elevation: 15.0,
                  shape: CircleBorder(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16.2),
              Container(
                child: Text(
                  'Dedication',
                  style: TextStyle(
                    fontSize: 35.0,
                    letterSpacing: 1.0,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 11.9),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Text(
                  'Dont wish for a healthy body.\nWork hard for it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              //Button ------------------||-------------
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffffffff),
              Color(0xFFbde4f4),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50.0),
                child: Card(
                  child: CircleAvatar(
                    radius: 130.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(128),
                      child: Image.asset('images/women-running.jpeg'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  elevation: 15.0,
                  shape: CircleBorder(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16.2),
              Container(
                child: Text(
                  'Motivation',
                  style: TextStyle(
                    fontSize: 35.0,
                    letterSpacing: 1.0,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 11.9),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Text(
                  'Creating a healthy daily routine\n keeps you grounded and can have a big impact\n on your physical and mental health. ',
                  textAlign: TextAlign.center,
                  style: subTextStyle,
                ),
              ),
              //Button ------------------||-------------
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFcffffe),
              Color(0xFFf9f7d9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50.0),
                child: Card(
                  child: CircleAvatar(
                    radius: 130.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(118),
                      child: Image.asset('images/illustration.jpeg'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  elevation: 15.0,
                  shape: CircleBorder(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16.2),
              Container(
                child: Text(
                  'Your Personal Trainer',
                  style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 1.0,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 11.9),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Text(
                  'We bring to you Nutrical.\nYour personal trainer in your pocket \ncustomized to fulfill your goals.',
                  textAlign: TextAlign.center,
                  style: subTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Card(
                child: CircleAvatar(
                  radius: 130.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(128),
                    child: Image.asset('images/NutriCal_logo.jpeg'),
                  ),
                  backgroundColor: Colors.white,
                ),
                elevation: 15.0,
                shape: CircleBorder(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'NutriCal',
                style: TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 1.0,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'With NutriCal, you can always plan\nyour goals and work hard to achieve them.',
                  textAlign: TextAlign.center,
                  style: subTextStyle,
                ),
              ),
            ),
            //Button ------------------||-------------
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xFFfd8c04),
                child: MaterialButton(
                  minWidth: 150.0,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    //Gender page transition goes here
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Gender();
                    }));
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
        body: Stack(
      children: [
        LiquidSwipe(
          pages: pages,
          fullTransitionValue: 700,
          enableLoop: false,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          slideIconWidget: Icon(Icons.arrow_back_ios_rounded),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                      print("Gender Screen");
                      Navigator.popAndPushNamed(context, '/gender');
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

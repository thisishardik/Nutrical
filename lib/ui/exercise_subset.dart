import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrical/model/bottomnav.dart' as bn;

int _currentIndex = 1;

class ExerciseSub extends StatefulWidget {
  @override
  _ExerciseSubState createState() => _ExerciseSubState();
}

class _ExerciseSubState extends State<ExerciseSub> {
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, '0') +
          ':' +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ':' +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    });
  }

  void startstopwatch() {
    setState(() {
      stopispressed = false;
      startispressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      startispressed = true;
      resetispressed = true;
      stoptimetodisplay = '00:00:00';
    });
    swatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bn.bottomnav(_currentIndex, context),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 22,
              horizontal: MediaQuery.of(context).size.width / 15,
            ),
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
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Running',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '30 - 90 min course',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[200],
                            ),
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/male.png'),
                        radius: 30.0,
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Live happier\nand healthier\nwith a great\nstamina developing\nrunning sessions.',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[200],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: Image.asset(
                          'images/running.png',
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: CircleAvatar(
              radius: 101.0,
              backgroundColor: Colors.orange,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100.0,
                child: Text(
                  stoptimetodisplay,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black54)),
                  color: Colors.white,
                  textColor: Colors.orange,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {
                    startispressed ? startstopwatch() : null;
                  },
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.black54,
                    child: CircleAvatar(
                        radius: 19.0,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            Icons.restore,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            resetispressed ? null : resetstopwatch();
                          },
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.black54,
                    child: CircleAvatar(
                        radius: 19.0,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            Icons.stop,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            stopispressed ? null : stopstopwatch();
                          },
                        )),
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

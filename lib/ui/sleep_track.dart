import 'dart:ui';

import 'package:flutter/material.dart';

class SleepTrack extends StatefulWidget {
  @override
  _SleepTrackState createState() => _SleepTrackState();
}

class _SleepTrackState extends State<SleepTrack> {
  String sleepstart = '09:00 PM';
  String sleepend = '05:00 AM';
  String totalsleeptime = "8";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFFF07030),
                  Color(0xFFED8F2F),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 10.0, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        'Sleep Track',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/bitemoji.jpg'),
                      radius: 40.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'images/sleeptrackbg.PNG',
                  fit: BoxFit.fill,
                )),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .27,
                    padding:
                        EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      color: Colors.grey[300],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Sleep Start',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          sleepstart,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Container(
                    //  width: MediaQuery.of(context).size.width ,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .10,
                        top: 5.0,
                        bottom: 5.0,
                        right: 15.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Sleep Time',
                          style:
                              TextStyle(color: Colors.orange, fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          totalsleeptime,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Hours',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .27,
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      color: Colors.grey[300],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Sleep End',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          sleepend,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Divider(
              thickness: 3.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Colors.black12,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Normal Night Hours Sleep Time',
                style: TextStyle(color: Colors.black))
          ],
        ),
      ),
    );
  }
}

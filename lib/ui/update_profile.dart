import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:nutrical/utilities.dart';
import 'package:nutrical/model/bottomnav.dart' as bn;

class Update_Profile extends StatefulWidget {
  @override
  _Update_ProfileState createState() => _Update_ProfileState();
}

//int _currentIndex = 4;

class _Update_ProfileState extends State<Update_Profile> {
  bool isselect = true, isselect1 = true;
  int key = 0, key1 = 0;
  String email = '';
  String dob = 'Date of Birth';
  String weight = 'Weight in kgs';
  int w = -1;
  String height = 'Height in cm';
  int h = -1;
  String name = '';
  String error = '';
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        bottomNavigationBar: bn.bottomnav(_currentIndex, context),
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
                child: Text(
              'Update Profile',
              style: mainTextStyle,
            )),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CircleAvatar(
              radius: 51.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/male.png'),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
                child: FlatButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.create),
                    label: Text(
                      'Update Your Profile Picture',
                      style: TextStyle(fontSize: 13.0, color: Colors.black54),
                    ))),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 220.0, 10.0),
            child: Text(
              'User Name',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'User Name',
                  hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
              onChanged: (val) {
                name = val;
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 250.0, 10.0),
            child: Text(
              'Email',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // email here
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 200.0, 10.0),
            child: Text(
              'Date of Birth',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // Date of Birth here
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '$dob',
                      hintStyle:
                          TextStyle(color: Colors.grey[700], fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(top: 20, bottom: 20, left: 38),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        dob = val;
                      });
                    },
                  ),
                  Positioned(
                    top: 7.0,
                    right: 10.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.orange[700],
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
                          });
                        });
                      },
                    ),
                  ),
                ],
              )),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 250.0, 10.0),
            child: Text(
              'Gender',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // email here
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Gender',
                  hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 250.0, 10.0),
            child: Text(
              'BMI',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // email here
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Your BMI',
                  hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 250.0, 10.0),
            child: Text(
              'Aim',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // email here
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Your Aim',
                  hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  )),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 250.0, 10.0),
            child: Text(
              'Weight',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // weight here
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '$weight',
                      hintStyle:
                          TextStyle(color: Colors.grey[700], fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(top: 20, bottom: 20, left: 38),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        weight = val;
                      });
                    },
                  ),
                  Positioned(
                    top: 7.0,
                    right: 10.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.0,
                        color: Colors.orange[700],
                      ),
                      onPressed: () {
                        _showChoiceWeight(context);
                      },
                    ),
                  ),
                ],
              )),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 180.0, 10.0),
            child: Text(
              'Desired Weight',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // weight here
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '$weight',
                      hintStyle:
                          TextStyle(color: Colors.grey[700], fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(top: 20, bottom: 20, left: 38),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        weight = val;
                      });
                    },
                  ),
                  Positioned(
                    top: 7.0,
                    right: 10.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30.0,
                        color: Colors.orange[700],
                      ),
                      onPressed: () {
                        _showChoiceWeight(context);
                      },
                    ),
                  ),
                ],
              )),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 250.0, 10.0),
            child: Text(
              'Height',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
            ),
          ),

          // height here
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(top: 10, bottom: 40.0),
            child: Stack(
              children: [
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: '$height',
                    hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
                    contentPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 38),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      weight = val;
                    });
                  },
                ),
                Positioned(
                  top: 7.0,
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.0,
                      color: Colors.orange[700],
                    ),
                    onPressed: () {
                      _showChoiceHeight(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Center(
                      child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  )),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.35,
                  margin: EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange[600], width: 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    ));
  }

  Future<void> _showChoiceWeight(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Weight'),
            content: SingleChildScrollView(
                child: NumberPicker.integer(
                    infiniteLoop: true,
                    initialValue: w < 0 ? 50 : w,
                    minValue: 0,
                    maxValue: 150,
                    onChanged: (val) {
                      setState(() {
                        w = val;
                        weight = val.toString() + ' Kg';
                      });
                    })),
          );
        });
  }

  Future<void> _showChoiceHeight(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Height'),
            content: SingleChildScrollView(
                child: NumberPicker.integer(
                    infiniteLoop: true,
                    initialValue: w < 0 ? 350 : w,
                    minValue: 0,
                    maxValue: 350,
                    onChanged: (val) {
                      setState(() {
                        h = val;
                        height = val.toString() + ' cm';
                      });
                    })),
          );
        });
  }
}

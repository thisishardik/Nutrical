import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nutrical/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isselect = true, isselect1 = true;
  int key = 0, key1 = 0;
  String email = '';
  String password = '', confirm_password = '';
  String name = '';
  String error = '';
  String toastMessage = "";
  bool showSpinner = false;
  bool showFloatingToast = false;
  final _auth = FirebaseAuth.instance;

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

  Widget _showSuccessDialog(String successMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text('Authentication Successful'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(successMessage),
                ],
              ),
            ),
            actions: <Widget>[
              PlatformDialogAction(
                child: Text('Log In'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/carousel');
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GFFloatingWidget(
        verticalPosition: MediaQuery.of(context).size.height * 0.8,
        horizontalPosition: MediaQuery.of(context).size.width * 0.1,
        showblurness: showFloatingToast,
        blurnessColor: Colors.black54,
        child: showFloatingToast
            ? GFToast(
                backgroundColor: Colors.black,
                text: toastMessage,
                type: GFToastType.rounded,
                textStyle: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.75,
                button: GFButton(
                  onPressed: () {
                    setState(() {
                      showFloatingToast = false;
                    });
                  },
                  text: 'OK',
                  type: GFButtonType.transparent,
                  color: GFColors.SUCCESS,
                ),
                autoDismiss: false,
              )
            : Container(),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // Text(error,style: TextStyle(fontSize: 18.0,color: Colors.red),),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                        child: Text(
                      'Sign Up',
                      style: mainTextStyle,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Create account',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 50.0, 220.0, 10.0),
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
                          hintStyle:
                              TextStyle(color: Colors.grey[700], fontSize: 14),
                          contentPadding:
                              EdgeInsets.only(top: 20, bottom: 20, left: 38),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: 'Email Address',
                          hintStyle:
                              TextStyle(color: Colors.grey[700], fontSize: 14),
                          contentPadding:
                              EdgeInsets.only(top: 20, bottom: 20, left: 38),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20.0, 230.0, 10.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          TextField(
                            obscureText: isselect,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey[700], fontSize: 14),
                              contentPadding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 38),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          Positioned(
                            top: 7.0,
                            right: 10.0,
                            child: IconButton(
                              icon: (key % 2 == 0)
                                  ? Image.asset(
                                      'images/closed_eye.png',
                                      scale: 8.0,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye,
                                    ),
                              onPressed: () {
                                if (key % 2 == 0) {
                                  setState(() {
                                    isselect = false;
                                    key = key + 1;
                                  });
                                } else {
                                  setState(() {
                                    isselect = true;
                                    key = key + 1;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
                    height: 50.0,
                    width: double.maxFinite,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        print(name);
//                                                      print(Email);
//                                                      print(Password);
//                                                        _firestore.collection('Profile-info').add({
//                                                          'Name': name
//                                                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                          FirebaseUser user = newUser.user;
                          var userUpdateInfo = UserUpdateInfo();
                          userUpdateInfo.displayName = name;
                          await user.updateProfile(userUpdateInfo);

                          if (newUser != null) {
                            setState(() {
                              _showSuccessDialog(
                                  "You are registered successfully.");
                              showSpinner = false;
                            });
                          }
                        } catch (e) {
                          setState(() {
                            switch (e.code) {
                              case 'ERROR_EMAIL_ALREADY_IN_USE':
                                toastMessage = "Email already exists.";
                                break;
                              case 'ERROR_INVALID_EMAIL':
                                toastMessage = "Invalid email address";
                                break;
                              case 'ERROR_WEAK_PASSWORD':
                                toastMessage =
                                    "Please choose a stronger password.";
                                break;
                            }
                            showFloatingToast = true;
                            showSpinner = false;
                          });
                        }
                      },
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            colors: [Colors.orange[700], Colors.orange[200]],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have an account? ',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              print('Login pressed');
                              Navigator.popAndPushNamed(context, '/login');
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

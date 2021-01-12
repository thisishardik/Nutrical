import 'package:flutter/material.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutrical/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool isselect = true;
  int key = 0;
  bool showSpinner = false;
  bool showFloatingToast = false;
  final _auth = FirebaseAuth.instance;
  String toastMessage = "";
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    // assert(currentUser.uid == user.uid);

    return user;
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
                width: MediaQuery.of(context).size.width * 0.7,
                button: GFButton(
                  onPressed: () {
                    setState(() {
                      showFloatingToast = false;
                    });
                  },
                  text: 'CLOSE',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                        child: Text(
                      'Login',
                      style: mainTextStyle,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Access account',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 50.0, 280.0, 0.0),
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
                    margin: EdgeInsets.only(top: 20),
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
                            borderSide: BorderSide(color: Colors.orange[600]),
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
                    padding: const EdgeInsets.fromLTRB(10.0, 30.0, 240.0, 10.0),
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
                  // GestureDetector(
                  //   onTap: () {
                  //     print('Forget Password pressed');
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(200.0, 15.0, 0.0, 10.0),
                  //     child: Text(
                  //       'Forget Password?',
                  //       style: TextStyle(
                  //           fontSize: 12.0,
                  //           fontWeight: FontWeight.w500,
                  //           fontFamily: 'Roboto'),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.0,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: Colors.orange),
                          ),
                        ),
                        Container(
                          height: 1.0,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Google Login Pressed');
                            signInWithGoogle().whenComplete(() async {
                              Navigator.popAndPushNamed(context, '/dashboard');
                            });
                            setState(() {
                              showSpinner = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Image.asset(
                              'images/google.png',
                              height: 40.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Facebook Login Pressed');
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Image.asset(
                              'images/facebook.png',
                              height: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        try {
                          final newUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.popAndPushNamed(context, '/dashboard');
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } catch (e) {
                          print(e);
                          setState(() {
                            toastMessage = 'Authentication Error.';
                            showFloatingToast = true;
                            showSpinner = false;
                          });
                        }
//                    Navigator.popAndPushNamed(context, '/carousel');
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
                            "Login",
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
                    padding: EdgeInsets.only(top: 65.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            letterSpacing: 0.3,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              print('Sign up pressed');
                              Navigator.popAndPushNamed(context, '/signup');
                            },
                            child: Text(
                              'Sign Up',
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

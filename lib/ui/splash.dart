import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[NutriCalLogo()],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.8),
                  ),
                  Text(
                    "Powered By",
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.8)),
                  Text("Inventuers",
                      style: TextStyle(
                          color: Colors.green[300],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class NutriCalLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/NutriCal_logo.jpeg');
    Image image = Image(
      image: assetImage,
      width: 400.0,
      height: 400.0,
    );
    return Container(child: image);
  }
}

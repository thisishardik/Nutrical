import 'package:flutter/material.dart';
import 'package:nutrical/new_ui/height_slider/height_theme.dart';
import 'package:nutrical/ui/bmi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:nutrical/model/BMI_Cal.dart' as bmical;
// import 'package:test_app/humidity_slider/weight_fun_icons_icons.dart';
// import 'package:test_app/humidity_slider/weight_theme.dart';

import 'height_humidity.dart';

class HumidityInfoH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var value = context.watch<Humidity>().finalValue;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Container(
            height: 470,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Subtitle('Your Height'),
                SizedBox(height: 10),
                Text(
                  '${value} cm',
                  style: TextStyle(
                    color: Color(0xFF060829),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(
                  'images/boy_height.png',
                  height: 220,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    bmical.height = value;
                    print(bmical.height);
                    bmical.finalheight = bmical.height.toString();

                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: BMI(),
                        ),
                        (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.lightBlueAccent,
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
              ],
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class AnimatedLetter extends StatefulWidget {
  AnimatedLetter({Key key, this.letter}) : super(key: key);

  final String letter;

  @override
  _AnimatedLetterState createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  String currentLetter;
  String prevLetter;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    currentLetter = widget.letter;
    prevLetter = widget.letter;
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedLetter oldWidget) {
    if (widget.letter != oldWidget.letter) {
      setState(() {
        prevLetter = oldWidget.letter;
        currentLetter = widget.letter;
        controller
          ..reset()
          ..forward();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Container(
            width: 48,
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -controller.value * 50),
                  child: Opacity(
                    opacity: 1 - controller.value,
                    child: Text(
                      prevLetter,
                      style: currentHumidityStyle,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 50 - controller.value * 50),
                  child: Opacity(
                    opacity: controller.value,
                    child: Text(
                      currentLetter,
                      style: currentHumidityStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrical/new_ui/height_slider/height_theme.dart';
// import 'package:test_app/humidity_slider/weight_fun_icons_icons.dart';
// import 'package:test_app/humidity_slider/weight_theme.dart';

class SliderBall extends StatelessWidget {
  const SliderBall({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: BrandColors.sugarCane,
      ),
      height: kBallSize,
      width: kBallSize,
      alignment: Alignment.center,
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

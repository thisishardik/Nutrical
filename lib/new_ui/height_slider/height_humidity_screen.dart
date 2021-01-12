import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'height_humidity.dart';
import 'height_humidity_congfig.dart';
import 'height_humidity_info.dart';
import 'height_scaffold.dart';
import 'height_slider.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => HumidityConfigH(80, 220)),
        ChangeNotifierProvider(create: (_) => Humidity())
      ],
      child: HSScaffold(
        activeIndex: 1,
        body: HumiditySliderPage(),
      ),
    );
  }
}

class HumiditySliderPage extends StatelessWidget {
  const HumiditySliderPage({Key key}) : super(key: key);

  final bool kShowBack = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: kShowBack
            ? DecorationImage(
                image: AssetImage("assets/design.png"),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 208,
            child: HumiditySlider(),
          ),
          Expanded(child: HumidityInfoH())
        ],
      ),
    );
  }
}

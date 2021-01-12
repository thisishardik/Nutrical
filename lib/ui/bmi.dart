import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:nutrical/model/BMI_Cal.dart' as bmical;

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  double bmi = 0.0;
  String c = '';

  @override
  void initState() {
    super.initState();
    bmi = bmical.bmicalculation(bmical.height, bmical.weight);
    bmical.finalbmi = bmi.toString();
    c = bmical.classes(bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF07030),
                      Color(0xFFED8F2F),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                  child: Text(
                'BMI',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.5,
                    fontWeight: FontWeight.w500),
              )),
            ),
            Container(
                margin: EdgeInsets.only(top: 30.0),
                child: SfRadialGauge(
                    enableLoadingAnimation: true,
                    animationDuration: 2000,
                    axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 10,
                          maximum: 40.0,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 10,
                                endValue: 18.5,
                                color: Colors.blueGrey),
                            GaugeRange(
                                startValue: 18.5,
                                endValue: 24.9,
                                color: Colors.green),
                            GaugeRange(
                                startValue: 25.0,
                                endValue: 29.9,
                                color: Colors.amber),
                            GaugeRange(
                                startValue: 30.0,
                                endValue: 40.0,
                                color: Colors.red)
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(value: bmi)
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Container(
                                  child: Text(
                                    '${bmi.toString().substring(0, 4)}\nBMI',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.5)
                          ])
                    ])),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0),
              child: Row(
                children: [
                  Text(
                    '${bmical.wl}\n\tlbs',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontFamily: "AbrilFatface",
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${bmical.wk}\n\tkg',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontFamily: "AbrilFatface",
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Class',
              style: TextStyle(
                fontSize: 29.5,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              c,
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontFamily: 'Varela',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/your_desire_weight', (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.orange,
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
        )),
      ),
    );
  }
}

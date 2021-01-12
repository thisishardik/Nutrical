import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nutrical/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'dart:math' as math;

import 'fintness_app_theme.dart';

class MedView extends StatefulWidget {
  double totalCalories;

  MedView({this.totalCalories});

  @override
  _MedViewState createState() => _MedViewState();
}

class _MedViewState extends State<MedView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform(
          transform: new Matrix4.translationValues(0.0, 30 * (1.0 - 0.5), 0.0),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 48,
                                      width: 2,
                                      decoration: BoxDecoration(
                                        color: HexColor('#87A0E5')
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 2),
                                            child: Text(
                                              'Eaten',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: -0.1,
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 28,
                                                height: 28,
                                                child: Image.asset(
                                                    "assets/fitness_app/eaten.png"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 3),
                                                child: Text(
                                                  '${widget.totalCalories.ceil()}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: FitnessAppTheme
                                                        .darkerText,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 3),
                                                child: Text(
                                                  'Kcal',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    letterSpacing: -0.2,
                                                    color: FitnessAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 48,
                                      width: 2,
                                      decoration: BoxDecoration(
                                        color: HexColor('#F56E98')
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 2),
                                            child: Text(
                                              'Burnt',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: -0.1,
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 28,
                                                height: 28,
                                                child: Image.asset(
                                                    "assets/fitness_app/burned.png"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 3),
                                                child: Text(
                                                  '1025',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: FitnessAppTheme
                                                        .darkerText,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, bottom: 3),
                                                child: Text(
                                                  'Kcal',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    letterSpacing: -0.2,
                                                    color: FitnessAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 16),
                        //   child: Center(
                        //     child: Stack(
                        //       overflow: Overflow.visible,
                        //       children: <Widget>[
                        //         Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Container(
                        //             width: 100,
                        //             height: 100,
                        //             decoration: BoxDecoration(
                        //               color: FitnessAppTheme.white,
                        //               borderRadius: BorderRadius.all(
                        //                 Radius.circular(100.0),
                        //               ),
                        //               border: new Border.all(
                        //                   width: 4,
                        //                   color: FitnessAppTheme.nearlyDarkBlue
                        //                       .withOpacity(0.2)),
                        //             ),
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //               children: <Widget>[
                        //                 Text(
                        //                   '984',
                        //                   textAlign: TextAlign.center,
                        //                   style: TextStyle(
                        //                     fontFamily:
                        //                         FitnessAppTheme.fontName,
                        //                     fontWeight: FontWeight.normal,
                        //                     fontSize: 24,
                        //                     letterSpacing: 0.0,
                        //                     color:
                        //                         FitnessAppTheme.nearlyDarkBlue,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   'Kcal left',
                        //                   textAlign: TextAlign.center,
                        //                   style: TextStyle(
                        //                     fontFamily:
                        //                         FitnessAppTheme.fontName,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 12,
                        //                     letterSpacing: 0.0,
                        //                     color: FitnessAppTheme.grey
                        //                         .withOpacity(0.5),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.all(4.0),
                        //           child: CustomPaint(
                        //             painter: CurvePainter(colors: [
                        //               FitnessAppTheme.nearlyDarkBlue,
                        //               HexColor("#8A98E8"),
                        //               HexColor("#8A98E8")
                        //             ], angle: 140 + (360 - 140) * (1.0 - 0.5)),
                        //             child: SizedBox(
                        //               width: 108,
                        //               height: 108,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SleekCircularSlider(
                          ///inital value === eaten - burnt
                          initialValue: 1,
                          min: 0,
                          max: widget.totalCalories / 100,
                          appearance: CircularSliderAppearance(
                            customColors: CustomSliderColors(
                              progressBarColors: [
                                Color(0xFF0278ae),
                                Color(0xFFa5ecd7),
                              ],
                              trackColor: Colors.blueGrey[100],
                            ),
                            counterClockwise: false,
                            startAngle: 270,
                            angleRange: 360,
                            infoProperties: InfoProperties(
                                bottomLabelStyle: TextStyle(
                                    color: HexColor('#002D43'),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                mainLabelStyle: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                                bottomLabelText: 'left',
                                modifier: (double value) {
                                  final kcal = value.toInt();
                                  return '$kcal kcal';
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 8),
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.background,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Carbs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkText,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 85.0,
                                    ),
                                    child: GFProgressBar(
                                      alignment: MainAxisAlignment.start,
                                      leading: Text(''),
                                      percentage: 0.7,
                                      lineHeight: 4,
                                      animateFromLastPercentage: true,
                                      progressBarColor: Color(0xFF87A0E5),
                                      backgroundColor:
                                          HexColor('#87A0E5').withOpacity(0.2),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 4),
                                  //   child: Container(
                                  //     height: 4,
                                  //     width: 70,
                                  //     decoration: BoxDecoration(
                                  //       color: HexColor('#87A0E5').withOpacity(0.2),
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.circular(4.0)),
                                  //     ),
                                  //     child: Row(
                                  //       children: <Widget>[
                                  //         Container(
                                  //           width: ((70 / 1.2) * 0.5),
                                  //           height: 4,
                                  //           decoration: BoxDecoration(
                                  //             gradient: LinearGradient(colors: [
                                  //               HexColor('#87A0E5'),
                                  //               HexColor('#87A0E5')
                                  //                   .withOpacity(0.5),
                                  //             ]),
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(4.0)),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      '12g left',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Protein',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkText,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 85.0,
                                    ),
                                    child: GFProgressBar(
                                      percentage: 0.8,
                                      lineHeight: 4,
                                      leading: Text(''),
                                      animateFromLastPercentage: true,
                                      progressBarColor: HexColor('#F56E98'),
                                      backgroundColor:
                                          HexColor('#F56E98').withOpacity(0.2),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 4),
                                  //   child: Container(
                                  //     height: 4,
                                  //     width: 70,
                                  //     decoration: BoxDecoration(
                                  //       color: HexColor('#F56E98')
                                  //           .withOpacity(0.2),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(4.0)),
                                  //     ),
                                  //     child: Row(
                                  //       children: <Widget>[
                                  //         Container(
                                  //           width: ((70 / 2) * 0.2),
                                  //           height: 4,
                                  //           decoration: BoxDecoration(
                                  //             gradient: LinearGradient(colors: [
                                  //               HexColor('#F56E98')
                                  //                   .withOpacity(0.1),
                                  //               HexColor('#F56E98'),
                                  //             ]),
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(4.0)),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      '30g left',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Fat',
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 85.0,
                                      ),
                                      child: GFProgressBar(
                                        percentage: 0.8,
                                        lineHeight: 4,
                                        leading: Text(''),
                                        animateFromLastPercentage: true,
                                        progressBarColor: HexColor('#F1B440'),
                                        backgroundColor: HexColor('#F1B440')
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(right: 0, top: 4),
                                  //   child: Container(
                                  //     height: 4,
                                  //     width: 70,
                                  //     decoration: BoxDecoration(
                                  //       color: HexColor('#F1B440')
                                  //           .withOpacity(0.2),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(4.0)),
                                  //     ),
                                  //     child: Row(
                                  //       children: <Widget>[
                                  //         Container(
                                  //           width: ((70 / 2.5) * 0.2),
                                  //           height: 4,
                                  //           decoration: BoxDecoration(
                                  //             gradient: LinearGradient(colors: [
                                  //               HexColor('#F1B440')
                                  //                   .withOpacity(0.1),
                                  //               HexColor('#F1B440'),
                                  //             ]),
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(4.0)),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      '10g left',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}

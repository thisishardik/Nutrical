import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class WorkoutsTimerPage extends StatefulWidget {
  @override
  _WorkoutsTimerPageState createState() => _WorkoutsTimerPageState();
}

class _WorkoutsTimerPageState extends State<WorkoutsTimerPage> {
  CountDownController _controller = CountDownController();
  bool _isPause = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blueGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: IconButton(
                        icon: Icon(
                          _isPause ? Icons.play_arrow : Icons.pause,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isPause) {
                              _isPause = false;
                              _controller.resume();
                            } else {
                              _isPause = true;
                              _controller.pause();
                            }
                          });
                          _isPause ? _controller.pause() : _controller.resume();
                        }),
                  ),
                ),
                CircularCountDownTimer(
                  duration: 20,
                  controller: _controller,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.blueGrey[100],
                  fillColor: Color(0xFF00bcd4),
                  backgroundColor: null,
                  strokeWidth: 15,
                  textStyle: TextStyle(
                      fontSize: 22.0,
                      letterSpacing: 5.0,
                      color: Colors.black,
                      fontFamily: 'BebasNeue',
                      fontWeight: FontWeight.w600),
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  onComplete: () {
                    _controller.restart();
                    print('Countdown Ended');
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blueGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh_sharp,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () => _controller.restart(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       setState(() {
      //         if (_isPause) {
      //           _isPause = false;
      //           _controller.resume();
      //         } else {
      //           _isPause = true;
      //           _controller.pause();
      //         }
      //       });
      //     },
      //     icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
      //     label: Text(_isPause ? "Resume" : "Pause")),
    );
  }
}

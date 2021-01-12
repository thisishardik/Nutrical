import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nutrical/new_ui/workouts_detail.dart';
import 'package:page_transition/page_transition.dart';

class WorkoutsIntroPage extends StatefulWidget {
  @override
  _WorkoutsIntroPageState createState() => _WorkoutsIntroPageState();
}

class _WorkoutsIntroPageState extends State<WorkoutsIntroPage> {
  List<String> workouts = [
    "Medicine Ball",
    "Push ups",
    "Chest Press",
    "V-raise",
    "Shoulder Press",
    "Halo",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/evan-work.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        'Workouts',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '"Stop saying tomorrow"',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.10,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Center(
                        child: Text(
                          "${workouts[index]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    );
                  },
                  autoplay: true,
                  itemCount: workouts.length,
                  scale: 0.5,
                  viewportFraction: 0.3,
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: WorkoutsDetailPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

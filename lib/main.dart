import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutrical/dashboard.dart';
import 'package:nutrical/mealselection.dart';
import 'package:nutrical/model/custom_dialogbox.dart';
import 'package:nutrical/new_ui/height_slider/height_humidity_screen.dart';
import 'package:nutrical/new_ui/workouts_detail.dart';
import 'package:nutrical/new_ui/workouts_intro.dart';
import 'package:nutrical/ui/bmi.dart';
import 'package:nutrical/ui/carousel.dart';
import 'package:nutrical/ui/exercise_subset.dart';
import 'package:nutrical/ui/gender.dart';
import 'package:nutrical/ui/login.dart';
import 'package:nutrical/ui/mealplan.dart';
import 'package:nutrical/ui/profile.dart';
import 'package:nutrical/ui/select_diet.dart';
import 'package:nutrical/ui/signup.dart';
import 'package:nutrical/ui/sleep_track.dart';
import 'package:nutrical/ui/step_tracker.dart';
import 'package:nutrical/ui/splash.dart';
import 'package:nutrical/ui/workout.dart';
import 'package:nutrical/ui/your_desire_weight.dart';
import 'package:nutrical/ui/your_height.dart';
import 'package:nutrical/ui/update_profile.dart';
import 'package:nutrical/ui/your_purpose.dart';
import 'package:nutrical/ui/your_weight.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nutrical/new_ui/workouts_timer_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrical/dashboard.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'dashboard.dart';
import 'dashboard.dart';
import 'ui/splash.dart';
import 'ui/splash.dart';

void main() {
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmg7MiE3Kn0/ODwTND4yOj99MDw+");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => Login(),
        '/splash': (context) => SplashScreen(),
        '/signup': (context) => SignUp(),
        '/carousel': (context) => Carousel(),
        '/gender': (context) => Gender(),
        '/your_weight': (context) => Your_Weight(),
        '/your_height': (context) => Your_Height(),
        '/bmi': (context) => BMI(),
        '/your_purpose': (context) => Your_Purpose(),
        '/your_desire_weight': (context) => Your_Desire_Weight(),
        '/select_diet': (context) => Select_Diet(),
        '/update_profile': (context) => Update_Profile(),
        '/profile_page': (context) => ProfilePage(),
        '/meal_selection': (context) => MealSelection(),
        '/meal_plan': (context) => MealPlan(),
        '/workout': (context) => Workout(),
        '/dashboard': (context) => Dashboard(),
        '/exercise_subset': (context) => ExerciseSub(),
        '/sleeptracker': (context) => SleepTrack(),
        // '/steptracker': (context) => StepTracker(),
      },
      home: FutureBuilder(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProfilePage();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

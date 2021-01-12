import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutrical/dashboard.dart';
import 'package:nutrical/ui/exercise_subset.dart';
import 'package:nutrical/ui/mealplan.dart';
import 'package:nutrical/ui/profile.dart';
import 'package:nutrical/ui/workout.dart';
import 'package:page_transition/page_transition.dart';

Widget bottomnav(_currentIndex, context) {
  return CurvedNavigationBar(
    backgroundColor: Colors.white,
    color: Colors.orange[600],
    buttonBackgroundColor: Colors.orange[500],
    height: 53.5,
    index: _currentIndex,
    animationDuration: Duration(
      milliseconds: 500,
    ),
    animationCurve: Curves.bounceInOut,
    items: <Widget>[
      Icon(Icons.home, size: 31, color: Colors.white),
      Icon(Icons.directions_run, size: 31, color: Colors.white),
      Icon(Icons.local_dining, size: 31, color: Colors.white),
      Icon(Icons.fitness_center, size: 31, color: Colors.white),
      Icon(Icons.person, size: 31, color: Colors.white),
    ],
    onTap: (index) {
      if (index == 0 && _currentIndex != index) {
        // Navigator.push(context, '/dashboard');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: Dashboard(),
          ),
        );
        print('Going to Dashboard');
      } else if (index == 1 && _currentIndex != index) {
        // Navigator.pushNamed(context, '/exercise_subset');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ExerciseSub(),
          ),
        );
        print('Going to Meal Selection');
      } else if (index == 2 && _currentIndex != index) {
        // Navigator.pushNamed(context, '/meal_plan');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MealPlan(),
          ),
        );
        print('Going to Meal Selection');
      } else if (index == 3 && _currentIndex != index) {
        // Navigator.pushNamed(context, '/workout');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: Workout(),
          ),
        );
        print('Going to Meal Selection');
      } else if (index == 4 && _currentIndex != index) {
        // Navigator.pushNamed(context, '/profile_page');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ProfilePage(),
          ),
        );
        print('Going to Meal Selection');
      }
    },
  );
}

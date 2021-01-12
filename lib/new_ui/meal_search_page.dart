import 'package:flutter/material.dart';
import 'file:///F:/Android/AndroidStudioProjects/nutrical_new/lib/new_ui/networking/food_items_pred.dart';
import 'file:///F:/Android/AndroidStudioProjects/nutrical_new/lib/new_ui/networking/food_model.dart';

class DataSearch extends SearchDelegate<String> {
  List foodList;
  DataSearch({this.foodList});

  List<String> foodItems = [];

  // Future buildFoodItemsList(String query) async {
  //   FoodItemsPredModel foodItemsPredModel = FoodItemsPredModel();
  //   var foodData = await foodItemsPredModel.getFoodPredDetails(query);
  //   try {
  //     for (var i = 0; i < foodData.length; i++) {
  //       foodItems.add(foodData[i]);
  //     }
  //   } catch (e) {
  //     print("Exception occurred : $e");
  //   }
  //   // for (var i = 0; i < foodItems.length; i++) {
  //   //   print("Food items are : ${foodItems[i]}");
  //   // }
  //   print("/********************/");
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ///implement a new screen with query as text
  }

  @override
  void showSuggestions(BuildContext context) async {
    FoodItemsPredModel foodItemsPredModel = FoodItemsPredModel();
    var foodData = await foodItemsPredModel.getFoodPredDetails(query);
    try {
      for (var i = 0; i < foodData.length; i++) {
        foodItems.add(foodData[i]);
      }
    } catch (e) {
      print("Exception occurred : $e");
    }
    // for (var i = 0; i < foodItems.length; i++) {
    //   print("Food items are : ${foodItems[i]}");
    // }
    print("/********************/");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? foodList
        : foodItems.where((element) => element.startsWith(query)).toList();

    print("Suggestion list ${suggestionList}");
    print("Food items are : ${foodItems}");

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

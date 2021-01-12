import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutrical/new_ui/all_meals_variety.dart';
import 'package:nutrical/new_ui/meal_detail_page.dart';
import 'dart:convert';

import 'package:page_transition/page_transition.dart';

class FoodSearchDelegate extends SearchDelegate<String> {
  List foodList;
  FoodSearchDelegate({this.foodList});

  @override
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
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _search(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  /// implement navigation and api call
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: AllMealsVarietyPage(
                        foodItem: snapshot.data[index],
                      ),
                    ),
                  );
                },
                leading: Icon(Icons.search_rounded, color: Colors.grey),
                title: RichText(
                  text: TextSpan(
                    text: snapshot.data[index]
                        .replaceFirst(
                            snapshot.data[index],
                            snapshot.data[index].substring(0, 1).toUpperCase() +
                                snapshot.data[index].substring(1).toLowerCase())
                        .substring(0, query.length),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: snapshot.data[index]
                            .replaceFirst(
                                snapshot.data[index],
                                snapshot.data[index]
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    snapshot.data[index]
                                        .substring(1)
                                        .toLowerCase())
                            .substring(query.length),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _search(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: AllMealsVarietyPage(
                        foodItem: snapshot.data[index],
                      ),
                    ),
                  );
                },
                leading: Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
                title: RichText(
                  text: TextSpan(
                    text: snapshot.data[index]
                        .replaceFirst(
                            snapshot.data[index],
                            snapshot.data[index].substring(0, 1).toUpperCase() +
                                snapshot.data[index].substring(1).toLowerCase())
                        .substring(0, query.length),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: snapshot.data[index]
                            .replaceFirst(
                                snapshot.data[index],
                                snapshot.data[index]
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    snapshot.data[index]
                                        .substring(1)
                                        .toLowerCase())
                            .substring(query.length),
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
        } else {
          return Container();
        }
      },
    );
  }

  Future _search() async {
    // final authority = 'jsonplaceholder.typicode.com';
    final uri =
        'https://api.edamam.com/auto-complete?q=$query&limit=10&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34';
    // final api =
    //     'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=$query&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34';
    // final path = 'todos';
    // final queryParameters = <String, String>{'title': query};
    // final uri = Uri.https(authority, path, queryParameters);
    final result = await http.get(uri);
    final list = json.decode(result.body) as List;
    return list.where((element) => element.startsWith(query)).toList();
  }
}

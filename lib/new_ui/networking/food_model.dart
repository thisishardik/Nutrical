import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodModel {
  Future getFoodDetails(String food) async {
    String api =
        'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=$food&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34';
    http.Response response = await http.get(api);
    var foodData = json.decode(response.body);
    return foodData;
  }
}

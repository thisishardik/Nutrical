import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchListViewExample extends StatefulWidget {
  @override
  _SearchListViewExampleState createState() => _SearchListViewExampleState();
}

class _SearchListViewExampleState extends State<SearchListViewExample> {
  List<String> dogsBreedList = List<String>();
  List<String> tempList = List<String>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDogsBreed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _searchBar(),
                Expanded(
                  flex: 1,
                  child: _mainData(),
                )
              ],
            ),
          )),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Dog Breeds Here...",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          _filterDogList(text);
        },
      ),
    );
  }

  Widget _mainData() {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: dogsBreedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                  dogsBreedList[index],
                ));
              }),
    );
  }

  _filterDogList(String text) {
    if (text.isNotEmpty) {
      setState(() {
        dogsBreedList = tempList;
      });
    } else {
      final List<String> filteredBreeds = List<String>();
      tempList.map((breed) {
        if (breed.contains(text.toString().toUpperCase())) {
          filteredBreeds.add(breed);
        }
      }).toList();
      setState(() {
        dogsBreedList.clear();
        dogsBreedList.addAll(filteredBreeds);
      });
    }
  }

  _fetchDogsBreed() async {
    setState(() {
      isLoading = true;
    });
    tempList = List<String>();
    final response = await http.get(
        'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=pizza&app_id=27abaa43&app_key=a7d32390010feefd067ab735fb833d34');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      jsonResponse['message'].forEach((breed, subbreed) {
        tempList.add(breed.toString().toUpperCase());
      });
    } else {
      throw Exception("Failed to load Dogs Breeds.");
    }
    setState(() {
      dogsBreedList = tempList;
      isLoading = false;
    });
  }
}

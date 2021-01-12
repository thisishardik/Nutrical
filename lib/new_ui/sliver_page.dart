import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  SolidController _controller = SolidController();
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            snap: false,
            backgroundColor: Colors.blue[200],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Let's make you fit",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Varela',
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              background: Image.asset(
                "images/workout.jpg",
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Level",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Varela"),
                      ),
                      Text(
                        "Intermediate",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Varela"),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pinkAccent,
                          Colors.lightBlueAccent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "kCal",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Varela"),
                      ),
                      Text(
                        "180",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Varela"),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pinkAccent,
                          Colors.lightBlueAccent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Varela"),
                      ),
                      Text(
                        "15:00 mins",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Varela"),
                      ),
                    ],
                  ),
                ],
              ),
              FloatingActionButton(
                  //This is the try button to be put on every list card--------->>>>>>>>>>>>
                  child: Text("TRY"),
                  onPressed: () {
                    _controller.isOpened
                        ? _controller.hide()
                        : _controller.show();
                  }),
              //  LISTVIEW BUILDER WILL COME HERE-------------------****--------------------!
            ],
          ),
        ),
        bottomSheet: SolidBottomSheet(
          controller: _controller,
          canUserSwipe: false,
          toggleVisibilityOnTap: false,
          maxHeight: 500,
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.blue[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    "Pull up",
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.black,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                // Center(child: Image.asset("images/bodybuilder.jpg",height: 175,width: 175,)),
                Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://i.pinimg.com/originals/c4/15/13/c41513afb3abb500d59dfae4a5ebbf33.gif",
                          height: 150,
                          width: 200,
                        ))),
                Center(
                  child: Text(
                    "Gif-Source:Spotebi.com",
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.black,
                      fontSize: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Duration: 1:30",
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Description: Pull up helps to build the shoulder muscles and it also enhance the torso muscles.",
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

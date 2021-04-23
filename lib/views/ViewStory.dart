import 'package:flutter/material.dart';

class ViewStory extends StatefulWidget {
  String id;

  ViewStory (this.id);
  @override
  _ViewStoryState createState() => _ViewStoryState(this.id);
}

class _ViewStoryState extends State<ViewStory> {
  double screenHeight;
  double screenWidth;
  String id;
  _ViewStoryState(this.id);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/home-bg.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
    );

  }
}

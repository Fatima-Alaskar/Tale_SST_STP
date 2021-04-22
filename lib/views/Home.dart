import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  double screenHeight;
  double screenWidth;


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
                image: AssetImage("assets/images/Home.png"),
                fit: BoxFit.cover
            )
        ),


        child: Column(
        children: [
        Center(
            child: Ink(
            decoration: const ShapeDecoration(
            color: Color(0xFF72A6C3),
            shape: CircleBorder(),
          ),

             child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget> [
              Expanded(
                child: Icon(Icons.favorite,
                 color: Colors.white),
              ),
              Expanded(
              child: Icon(Icons.addchart_rounded,
              color: Colors.white)),

          ],),
        ),
        ),

        SizedBox(),

         Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
            child: FlatButton(
             onPressed: (){
               Navigator.pushNamed(context, '/HomePage');

             },
              child: Image(image: AssetImage("assets/images/ypung.png")),

            ),),
            Expanded(
            child: FlatButton(
             onPressed: (){
               Navigator.pushNamed(context, '/Page');


             },
             child: Image(image: AssetImage("assets/images/pre.png")),
            ),
          ),
    ],

    ),
    ],),
    ),
    );

  }
}




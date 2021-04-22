import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  image: AssetImage("assets/images/Story inside.png"),
                  fit: BoxFit.cover
              )
          ),



          child: Stack(
            children:<Widget> [
          Column(
            children: [
          Container(
          decoration: new BoxDecoration(color: Color(0xFFC6F1FF)),
            alignment: Alignment.center,
            height: 240,
            child: Image.network("https://firebasestorage.googleapis.com/v0/b/taleteller-3a7b8.appspot.com/o/images%2FThe%20Frog.jpg?alt=media&token=337b063e-5682-4e2b-8956-ac61df804282",fit: BoxFit.fill)
           ),
            Align(
           alignment: Alignment.bottomRight,
            child: Icon(Icons.favorite_border),
               ),


              SizedBox(),

            ],
          ),
          Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: screenWidth / 3 * 2,
              height: 50,
              child: RaisedButton(
                  //child: Text("Want to read", style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0), ),
                  color: Color(0xFF8E97FD),
                  child: Row(
                    children: <Widget>[
                    Text("Want to read", style: TextStyle(color: Colors.white),),
                  Icon(Icons.menu_book_outlined, color: Colors.white,),],),

                  onPressed: ()  {
                     SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                      '/ViewStory', (Route<dynamic> route) => false);
                     });
                  }
              ),
            ),
          ),
          bottom: 75,
          left: 0
      ),
        ],
          ),
          ),
    );

  }
}


// Align(
// alignment: Alignment.topCenter,
// child: Image.network(
// //used_car.imageUrl,fit: BoxFit.fill
// // TODO: Should we add stream bulider?
// snapshots.data["img"][index].Images,
// ),
// ),
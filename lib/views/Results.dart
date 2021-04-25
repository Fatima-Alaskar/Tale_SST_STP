import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double screenHeight;
  double screenWidth;
  User user;
  double Lscore;
  double Rscore;

  // void initState() {
  //   super.initState();
  //   initUser();
  // }
  // initUser() async {
  //   user = await _auth.currentUser;
  //   FirebaseFirestore.instance.collection("listeningScore").doc(user.uid).get().then((value){
  //     FirebaseFirestore.instance.collection("ReadingScore").doc(user.uid).get().then((value){
  //       setState(() {
  //       Lscore = value.data["listeningScore"].toDouble();
  //     },
  //
  //     setState(() {
  //         Rscore= value.data["ReadScore"].toDouble();
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Results", style:TextStyle(
    fontSize: 10.0),),
            centerTitle: true,
          ),
          body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/images/Home-bg.png"),
          fit: BoxFit.cover)),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Card(
             margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
              leading: Icon(
              Icons.audiotrack,
              color: Color(0xFF185366)),
              title: Text('Listening Score',
              style: TextStyle(
              fontSize: 20.0,),))),
               Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
                leading: Icon(
                    Icons.auto_stories,
                    color: Color(0xFF185366)),
                title: Text('reading Score',
                  style: TextStyle(
                    fontSize: 20.0,),))),
               Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
                leading: Icon(
                    Icons.cast_for_education,
                    color: Color(0xFF185366)),
                title: Text('Educational level',
                  style: TextStyle(
                    fontSize: 20.0,),))),
               Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
                leading: Icon(
                    Icons.face_retouching_natural,
                    size: 40, ),
                title: Text('You are a hero, Keep reading',
                  style: TextStyle(
                    fontSize: 20.0,
                      letterSpacing:1.3,),))),

    ],),),);
  }
}

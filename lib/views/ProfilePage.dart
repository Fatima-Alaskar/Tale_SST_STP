import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tale_teller/views/Home.dart';
import 'package:tale_teller/views/NavBar.dart';
import 'package:tale_teller/views/editProfile.dart';




class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  double screenHeight;
  double screenWidth;
  User user;
  var name;
  var age;

  void initState() {
    super.initState();
    initUser(); }

  initUser() async {
    user = await _auth.currentUser;

    FirebaseFirestore.instance.collection('Userinfo').doc(user.uid).get().then((value) {
      setState(() {
        name=value.data()["Username"];
        age=value.data()["Age"];


      });
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF0DB4EA) ,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );}
          ),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => editProfile()),
                );}
          ),
        ],

      ),
      body: Container(

        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.fromLTRB(0,150,0,50),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Profile +logout.png"),
                fit: BoxFit.cover
            )
        ),
        child: ListView(children: <Widget>[

          Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: ListTile(
            leading: Icon(
                Icons.circle,
                color: Color(0xFF185366)),
            title:  Text('username: '+name,
              textAlign: TextAlign.center,),
            ),),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                        Icons.circle,
                        color: Color(0xFF185366)),
                    title: Text('Age: '+age,
                      textAlign: TextAlign.center,),
                  ),),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                        Icons.circle,
                        color: Color(0xFF185366)),
                    title: Text('Email: '+user?.email,
                      textAlign: TextAlign.center,),
                  ),),
              ],

            ),
          ),



        ]


        ),
      ),
    );
  }
}
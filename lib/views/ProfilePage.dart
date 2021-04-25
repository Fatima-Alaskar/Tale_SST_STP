import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_rounded),
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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Profile +logout.png"),
                fit: BoxFit.cover
            )
        ),
        child: ListView(children: <Widget>[
          Container(
            child:
            Text(name,
              textAlign: TextAlign.center,),
          ),
          Container(
            child:
            Text(age,
              textAlign: TextAlign.center,),
          ),
          Container(
            child:
            Text(user?.email,
              textAlign: TextAlign.center,),
          ),

          // UserAccountsDrawerHeader(
          //   accountName: Text(
          //     "${user?.displayName}",
          //     textAlign: TextAlign.center,
          //
          //   ),
          // accountEmail: Text(
          //   "${user?.email}",
          //   textAlign: TextAlign.right,
          // ),
          // accountEmail:Text(
          //   age
          //     ),
          //     currentAccountPicture: CircleAvatar(
          //       backgroundColor: Colors.grey,
          //       child: Text(
          //         user.displayName.characters.first,
          //         style: TextStyle(fontSize: 40.0, color: Colors.white),
          //       ),
          //     ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     //image: NetworkImage("${user?.photoUrl}"),
          //   ),
          //   // ),
          // ),

        ]


        ),
      ),
    );
  }
}
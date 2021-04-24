import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Favorite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double screenHeight;
  double screenWidth;

  User user;

  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
  }

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
                  image: AssetImage("assets/images/Home-bg.png"),
                  fit: BoxFit.cover
              )
          ),


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Center(
                  child: Ink(
                      decoration: const ShapeDecoration(
                        color: Color(0xFF72A6C3),
                        shape: CircleBorder(),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  <Widget> [
                          Expanded(
                            child: IconButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/Favorite');
                                },
                                color: Color(0xFF72A6C3),
                                highlightColor:Color(0xFFF50057),
                                icon: Icon( Icons.favorite,
                                    color: Colors.white),),),
                          Expanded(
                              child: IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, '/Results');
                                  },
                                  color: Color(0xFF72A6C3),
                                  highlightColor:Color(0xFFF50057),
                                  icon: Icon(Icons.addchart_rounded,
                                  color: Colors.white),),),

                        ],
                      )))),
              Expanded(
                flex: 10,
                child: FlatButton(
                  onPressed: (){
                    if (ValidAge()){
                      Navigator.pushNamed(context, '/YoungHome'); }
                    else {
                      AlertDialog(title: Text("Oops! you are not allowed to Open this library. "));}
                  },
                  child: Image(image: AssetImage("assets/images/ypung.png")),

                ),),

              Expanded(
                flex: 10,
                child: FlatButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/preschoolerHome');
                  },
                  child: Image(image: AssetImage("assets/images/pre.png")),
                ),
              ),
            ],
          ),
        )
    );
  }


  bool ValidAge(){
    var age;
    FirebaseFirestore.instance.collection('Userinfo').doc(user.uid).get().then((value) {
      setState(() {
        age=double.parse(value.data()["Age"]);


      });
    });
    if (age >5.9) {
      return true;
    }
    else return false;
  }


}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tale_teller/views/ProfilePage.dart';

import '../Global.dart';
import 'NavBar.dart';


class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  double screenHeight;
  double screenWidth;
  User user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _educationLevelController = TextEditingController();
  final collRef = FirebaseFirestore.instance.collection("Userinfo");

  void initState() {
    super.initState();
    initUser(); }

  initUser() async {
    user = await _auth.currentUser;

  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login-bg.png"),
                  fit: BoxFit.cover
              )
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Edit Profile",style: TextStyle(fontSize: 28, color: Colors.white),)
                              ],
                            ),

                            SizedBox(height: 20,),

                            Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  controller: _usernameController,
                                  validator: (String value) {
                                    if (value.isEmpty) return 'Please enter some text';
                                    return null;

                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Colors.white),
                                    // ),
                                    labelText: 'Username',

                                  ),

                                  cursorColor: Color(0xFF556036),
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),

                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  validator: (String value) {
                                    if (value.isEmpty) return 'Please enter your password';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelText: 'Password',

                                  ),
                                  // style: TextStyle(
                                  //     color: Colors.white, decorationColor: Colors.white),
                                  cursorColor: Color(0xFF556036),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextFormField(
                                      controller: _ageController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (String value) {
                                        if (value.isEmpty) return 'Please enter your age in numbers only';
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        labelText: 'Age',

                                      ),

                                      cursorColor: Color(0xFF556036),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),

                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: screenWidth / 3 * 2,
                      height: 50,
                      child: RaisedButton(
                          child: Text("Edit Profile", style: TextStyle(color: Colors.white),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0), ),
                          color: Color(0xFF185366),

                          onPressed: () async {
                            await _editProfile1();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProfilePage(),
                              ),
                                  (route) => false,
                            );
                          }
                      ),
                    ),
                  ),
                  bottom: 60,
                  left: 0
              ),

            ],
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Future<void> _editProfile1() async {
   await  user.updateEmail(_usernameController.text + "@taleteller.edu");
   await user.updatePassword(_passwordController.text);

    await FirebaseFirestore.instance.collection('Userinfo').doc(user.uid).update({'Username': _usernameController.text,
        'Age':   _ageController.text,//_ageController.value,
         });
   await user.reload();


  }
}
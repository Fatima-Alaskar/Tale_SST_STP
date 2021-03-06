import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tale_teller/models/Story.dart';
import 'package:tale_teller/views/StoryPage.dart';
import 'package:tale_teller/views/YoungHome.dart';


import '../Global.dart';
import 'Home.dart';
import 'NavBar.dart';

// If a widget can change—when a user interacts with it, for example—it's stateful. A stateless widget never changes. Icon , IconButton , and Text are examples of stateless widgets
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double screenHeight;
  double screenWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _educationLevelController = TextEditingController();
  final collRef = FirebaseFirestore.instance.collection("Userinfo");





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
                              Text("Sign up",style: TextStyle(fontSize: 28, color: Colors.white),)
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
                                  if (value.isEmpty) return 'Please enter username';
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
                                  // labelStyle: TextStyle(
                                  //     color: Colors.white),
                                ),
                                // style: TextStyle(
                                //     color: Colors.white, decorationColor: Colors.white),
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
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: screenWidth / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextFormField(
                                      controller: _educationLevelController,
                                      // obscureText: true,
                                      validator: (String value) {
                                        if (value.isEmpty) return 'Please enter your educational level';
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        labelText: 'Educational Level',
                                      ),
                                      cursorColor: Color(0xFF556036),
                                    ),
                                  ),
                                ),
                              ),
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
                        child: Text("Sign up", style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0), ),
                        color: Color(0xFF185366),

                        onPressed: () async {

                          if (_formKey.currentState.validate()) {
                            await _signUpWithEmailAndPassword();

                          }
                        }
                    ),
                  ),
                ),
                bottom: 60,
                left: 0
            ),
            Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: screenWidth / 3 * 2,
                      height: 50,
                      child: FlatButton(child: Text("Login"), onPressed: (){
                        SchedulerBinding.instance.addPostFrameCallback((_) {

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/LoginPage', (Route<dynamic> route) => false);
                        });
                      }, )
                  ),
                ),
                bottom: 15,
                left: 0
            )
          ],
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword() async {

    try {
      final User user = (await Global.auth.createUserWithEmailAndPassword(
        email: _usernameController.text + "@taleteller.edu",
        password: _passwordController.text,
      )).user;


      if(user != null){
        //create user update object
        user.updateProfile(displayName: _usernameController.text); //set user display name to your variable.
        //update the info
        await user.reload();
        DocumentReference documentReference = collRef.doc(user.uid);
        documentReference.set({
         'Username': _usernameController.text,
          'Age':   _ageController.text,//_ageController.value,

        });
        FirebaseFirestore.instance.collection('listeningScore').doc(user.uid.toString()).set({
          'Score':0,
        });

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  NavBar(),
            ),
                (route) => false,
          );
        });
      }else{
        Fluttertoast.showToast(
            msg: "Ops! Could not create Account 1",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Ops! Could not create Account",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


}
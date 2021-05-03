import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tale_teller/views/YoungHome.dart';

import '../Global.dart';
import 'Home.dart';
import 'NavBar.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double screenHeight;
  double screenWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                                Text("Log in",style: TextStyle(fontSize: 28, color: Colors.white),)
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
                                    if (value.isEmpty) return 'Please enter some text';
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
                          child: Text("Log in", style: TextStyle(color: Colors.white),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0), ),
                          color: Color(0xFF185366),

                          onPressed: () async {

                            if (_formKey.currentState.validate()) {
                              await _signInWithEmailAndPassword();

                            }
                          }
                      ),
                    ),
                  ),
                  bottom: 75,
                  left: 0
              ),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: screenWidth / 3 * 2,
                        height: 50,
                        child: FlatButton(child: Text("Forgot your Password"), onPressed: (){
                        }, )
                    ),
                  ),
                  bottom: 0,
                  left: 0
              ),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: screenWidth / 3 * 2,
                        height: 50,
                        child: FlatButton(child: Text("Create account"), onPressed: (){
                          SchedulerBinding.instance.addPostFrameCallback((_) {

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/SignUpPage', (Route<dynamic> route) => false);
                          });
                        }, )
                    ),
                  ),
                  bottom: 25,
                  left: 0
              )
            ],
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {

    await Firebase.initializeApp();

    try {
      final User user = (await Global.auth.signInWithEmailAndPassword(
        email: _usernameController.text + "@taleteller.edu",
        password: _passwordController.text,
      )).user;


      if(user != null){

        // if(user.emailVerified){
        SchedulerBinding.instance.addPostFrameCallback((_) {

          Fluttertoast.showToast(
              msg: "Yaay! User Login Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Color(0xFF556036),
              textColor: Colors.white,
              fontSize: 16.0
          );

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
            msg: "Ops! User Not Found",
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
          msg: "Wrong email or password",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  forgotPassword(){
    if(_usernameController.text.isNotEmpty){
      Global.auth.sendPasswordResetEmail(email: _usernameController.text + "@taleteller.edu");
      Fluttertoast.showToast(
          msg: "Reset Password Massage has been sent to your email",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xFF556036),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Please fill your email",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }
}
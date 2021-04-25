import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tale_teller/views/ViewStory.dart';
import 'package:tale_teller/views/preschoolerHome.dart';
import 'views/NewStory.dart';
import 'views/LoginPage.dart';
import 'views/SignUpPage.dart';
import 'views/YoungHome.dart';
import 'views/ProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/Home.dart';
import 'views/Favorite.dart';
import 'views/Results.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => HomePage(),
        '/NewStory': (BuildContext context) => NewStory(),
        // '/ContactUsPage': (BuildContext context) => ContactUsPage(),
        '/ProfilePage': (BuildContext context) => ProfilePage(),
        // '/AppMenuPage': (BuildContext context) => AppMenuPage(),
        '/LoginPage': (BuildContext context) => LoginPage(),
        '/SignUpPage': (BuildContext context) => SignUpPage(),
        '/PreShooler': (BuildContext context) => PreShooler(),
        '/Home': (BuildContext context) => Home(),
        '/Favorite': (BuildContext context) => Favorite(),
        '/Results': (BuildContext context) => Results(),




        // '/ContactUsPage': (BuildContext context) => ContactUsPage(),
        // '/PrivacyPolicyPage': (BuildContext context) => PrivacyPolicyPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double screenHeight;
  double screenWidth;

  _MyHomePageState(){
    initializeApp();
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
            image: AssetImage("assets/images/welcome-bg.png"),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 150,),
                Text("Welcome", style: TextStyle(fontSize: 28, color: Colors.white),),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: screenWidth / 3 * 2,
                  height: 50,
                  child: RaisedButton(
                    child: Text("Lets Goo !", style: TextStyle(color: Colors.white),),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0), ),
                    color: Color(0xFF185366),

                    onPressed: (){
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        //here we can change
                        Navigator.of(context).pushNamedAndRemoveUntil(
                         '/SignUpPage', (Route<dynamic> route) => false);
                      });
                    }
                    ),
                ),
              ),
              bottom: 150,
              left: 0
            )
          ],
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  initializeApp() async {
    await Firebase.initializeApp();
  }
}

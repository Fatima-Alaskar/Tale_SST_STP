import 'package:flutter/material.dart';
import 'package:tale_teller/views/LoginPage.dart';
import 'package:tale_teller/views/YoungHome.dart';
import 'Home.dart';
import 'ProfilePage.dart';
import 'LoginPage.dart';
import '../Global.dart';


class NavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    ProfilePage(),
    Home(),
    LoginPage(),
  ];



  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0DB4EA) ,
        selectedItemColor : Color(0xFF185366),
        unselectedItemColor: Colors.white,
        currentIndex:
        _currentIndex, // this will be set when a new tab is tapped
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        onTap: onTappedBar,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile'),

          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(

            icon: IconButton(
              icon: Icon(
                Icons.logout,
              ),
              onPressed: () {
                Global.auth.signOut();
              },
            ),
            title: new Text("Logout"),



          ),
        ],
      ),
    );
  }
}
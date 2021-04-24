import 'package:flutter/material.dart';
import 'package:tale_teller/views/LoginPage.dart';
import 'ProfilePage.dart';
import 'YoungHome.dart';
import 'LoginPage.dart';
import '../Global.dart';


class NavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    ProfilePage(),
    HomePage(),
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
        currentIndex:
        _currentIndex, // this will be set when a new tab is tapped
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
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



















// import 'package:characters/characters.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:sallaty_v1/screens/History.dart';
// import 'package:sallaty_v1/screens/Sign_in.dart';
// import 'package:sallaty_v1/screens/e_wallet.dart';
//
// import '../services/editProfile.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
//
// class myDrawer extends StatefulWidget {
//   @override
//   _myDrawerState createState() => _myDrawerState();
// }
//
// class _myDrawerState extends State<myDrawer> {
//   FirebaseUser user;
//
//   @override
//   void initState() {
//     super.initState();
//     initUser();
//   }
//
//   initUser() async {
//     user = await _auth.currentUser();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: ListView(children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: Text(
//               "${user?.displayName}",
//               textAlign: TextAlign.center,
//             ),
//             accountEmail: Text(
//               "${user?.email}",
//               textAlign: TextAlign.right,
//             ),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.grey,
//               child: Text(
//                 user.displayName.characters.first,
//                 style: TextStyle(fontSize: 40.0, color: Colors.white),
//               ),
//             ),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage("${user?.photoUrl}"),
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'تعديل الحساب',
//               textAlign: TextAlign.right,
//             ),
//             trailing: Wrap(
//               children: <Widget>[
//                 Icon(Icons.person), // icon-1// icon-2
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => editProfile()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text(
//               'سجل المشتريات',
//               textAlign: TextAlign.right,
//             ),
//             trailing: Wrap(
//               children: <Widget>[
//                 Icon(Icons.history), // icon-1// icon-2
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => History()),
//               );
//             },
//           ),
//
//           ListTile(
//             title: Text(
//               'محفظتي',
//               textAlign: TextAlign.right,
//             ),
//             trailing: Wrap(
//               children: <Widget>[
//                 Icon(Icons.account_balance_wallet), // icon-1// icon-2
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => e_wallet()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text(
//               ' تسجيل الخروج',
//               textAlign: TextAlign.right,
//             ),
//             trailing: Wrap(
//               children: <Widget>[
//                 Icon(Icons.call_missed_outgoing),
//               ],
//             ),
//             onTap: () async {
//               final FirebaseUser user = await _auth.currentUser();
//               if (user == null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Sign_in()),
//                 );
//                 Alert(
//                   context: context,
//                   type: AlertType.warning,
//                   title: "",
//                   desc: "No one has signed in. ",
//                   buttons: [
//                     DialogButton(
//                       child: Text(
//                         "Ok",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                       //onPressed: () => Navigator.pushNamed(context, '/Sign_in'),
//                       color: Colors.yellow[800],
//                     ),
//                   ],
//                 ).show();
//                 return;
//               }
//               await _auth.signOut();
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (BuildContext context) => Sign_in(),
//                 ),
//                     (route) => false,
//               );
//               Alert(
//                 context: context,
//                 type: AlertType.success,
//                 title: "",
//                 desc: "تم تسجيل الخروج",
//                 buttons: [
//                   DialogButton(
//                     child: Text(
//                       "Ok",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                     color: Colors.yellow[800],
//                   ),
//                 ],
//               ).show();
//             },
//           )
//         ]));
//   }
// }
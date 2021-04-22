// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../tale_teller_/lib/Global.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../../tale_teller_/lib/views/ProfilePage.dart';
// import '../../../tale_teller_/lib/views/HomePage.dart';
//
//
// class Favorite extends StatefulWidget {
//   @override
//   _FavoriteState createState() => _FavoriteState();
// }
//
// class _FavoriteState extends State<Favorite> {
//   FirebaseAuth user;
//   double screenHeight;
//   double screenWidth;
//   int _bottomNavigationBar = 1;
//   int tabindex = 1;
//   Widget _bodyWidget;
//  //List<Widget> FavoriteWidgetsList = [];
//
//   List<Favorites> _favorites;
//
//   @override
//   void initState(){
//     super.initState();
//     _favorites=[];
//   }
//   //Firebase
//   CollectionReference Favorite = FirebaseFirestore.instance.collection('');
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//
//     return Scaffold(
//       body: Container(height: screenHeight,
//         width: screenWidth,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/Favorite list.png"),
//               fit: BoxFit.cover
//           ),
//         ),
//
//         child: Column(
//           children: <Widget>[
//             Center(child: Text("Favorite Stories")),
//
//             Expanded(child: ListView.builder(
//                 itemCount: _favorites.length,
//                 itemBuilder: _, index){
//
//              return ListTile(
//               leading: Icon(Icons.favorite),
//               title: Text(_favorites[index].title)
//               //onTap:() {},);
//             },
//     ),
//     ],
//     ),
//       ),);
//
//       }


      //TODO: reconfigure bottom navigation bar again!

  //
  //           bottomNavigationBar: BottomNavigationBar(
  //           backgroundColor: Color(0xFF0DB4EA),
  //           onTap: (int tabIndex) {
  //             selectTap(tabIndex);
  //           },
  //           currentIndex: _bottomNavigationBar,
  //           type: BottomNavigationBarType.fixed,
  //           items: [
  //             BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.userAlt),
  //                 title: Text("Profile")),
  //             BottomNavigationBarItem(
  //                 icon: Icon(Icons.home), title: Text("Home")),
  //             BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.signOutAlt),
  //                 title: Text("Logout")),
  //           ]),
  //   );
  // }

//
//   selectTap(int tabIndex) {
//     tabindex = tabIndex;
//     setState(() {
//       _bottomNavigationBar = tabIndex;
//
//
//       switch (tabIndex) {
//         case 0 :
//           getBodyToProfilePage();
//           break;
//         case 1:
//           getBodyToHomePage();
//           break;
//         case 2:
//           getBodyToLogout();
//           break;
//       }
//     });
//   }
//
//   getBodyToProfilePage() {
//     setState(() {
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage()),
//         );
//   };);}}
//
//   getBodyToHomePage() {
//     setState(() {
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//       };}}
//
//   getBodyToLogout() {
//     Global.auth.signOut();
//
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       Navigator.of(context).pushNamedAndRemoveUntil(
//           '/LoginPage', (Route<dynamic> route) => false);
//     });
//   }
//
//
//
// }
//

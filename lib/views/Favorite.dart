import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}
//
class _FavoriteState extends State<Favorite> {
  FirebaseAuth user;
  double screenHeight;
  double screenWidth;
  int _bottomNavigationBar = 1;
  int tabindex = 1;
  Widget _bodyWidget;
  List<Widget> FavoriteWidgetsList = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
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
//         ListView()
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
}
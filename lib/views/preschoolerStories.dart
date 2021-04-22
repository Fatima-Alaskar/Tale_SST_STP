// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../models/Story.dart';
//
// class preSchoolerStories extends StatefulWidget {
//   @override
//   _preSchoolerStoriesState createState() => _preSchoolerStoriesState();
// }
//
// class _preSchoolerStoriesState extends State<preSchoolerStories> {
//   double screenHeight;
//   double screenWidth;
//
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: new AppBar(
//         title: Text("Add Story"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//             height: screenHeight,
//             width: screenWidth,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/images/login-bg.png"),
//                     fit: BoxFit.cover)),
//             child: Stack(
//               children: [
//             Column(
//             children: [
//             SizedBox(
//             height: 50,
//             ),
//         ],),],),
//     ),
//     ),
//     );
//   //           Widget storyPageWidget = GestureDetector(
//   //     child: Card(
//   //       child: Padding(
//   //         padding: const EdgeInsets.all(8.0),
//   //         child: Container(
//   //           // width: screenWidth,
//   //           height: 50,
//   //           child: Row(
//   //             crossAxisAlignment: CrossAxisAlignment.center,
//   //             children: [
//   //               Container(
//   //                 width: 50,
//   //                 height: 50,
//   //                 color: Color(0xFF185366),
//   //               ),
//   //               Padding(
//   //                 padding: const EdgeInsets.only(left: 8,right: 8),
//   //               )
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     )
//   // );
//
//
//   }
// }
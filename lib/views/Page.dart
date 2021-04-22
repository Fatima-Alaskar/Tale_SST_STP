import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../Global.dart';
import '../models/Story.dart';
import 'StoryDetails.dart';

class Storys extends StatefulWidget {
  @override
  _StorysState createState() => _StorysState();
}

class _StorysState extends State<Storys> {

  double screenHeight;
  double screenWidth;

  bool initialBody = true;

  Widget _bodyWidget;
  int _bottomNavigationBar = 1;
  int tabindex = 1;

  // List<Story> storyList = [];

  List<Widget> storyWidgetsList = [];

  Widget Stories;

  Widget dummyGridView;

  final TextEditingController _searchController = TextEditingController();



  refreshData(){

    // getStories();

    _bodyWidget = !initialBody? _bodyWidget : SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // SizedBox(height: 250,),
                Form(
                  // key: _searchFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        // SizedBox(height: 250,),
                        Container(
                          width: screenWidth - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                labelText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                suffix: Container(
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: RaisedButton(child: Text("Search"),onPressed: (){
                                    }),
                                  ),
                                ),
                              ),
                              cursorColor: Color(0xFF556036),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          storyWidgetsList.length > 0 ? Stories : Text(" "),
          // dummyGridView
          // GridView.count(
          //   crossAxisCount: 2,
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   children: [
          //     Text("Test"),
          //     Text("Test"),
          //   ],),
        ],
      ),
    );
  }

  getStories() {
    FirebaseFirestore.instance
        .collection('Story')
        .snapshots()
        .listen((documentSnapshot) => setState((){

      storyWidgetsList = [];

      for(QueryDocumentSnapshot fireBaseDocument in  documentSnapshot.docs){
        Story story = new Story();
        story.id = fireBaseDocument.id;
        story.title = fireBaseDocument.data()["Title"];
        story.category = fireBaseDocument.data()["Category"];
        story.language = fireBaseDocument.data()["Language"];
        story.educationalLevel = fireBaseDocument.data()["EducationLevel"];

        setState(() {
          Widget storyWidget = GestureDetector(
            child: Card(
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            story.educationalLevel.toString(),
                          ),
                        ),
                      ),
                      top: 0,
                      right: 0,
                    ),
                    Container(
                      height: 225,
                      width: screenWidth,
                      child: Column(children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Image.asset("assets/images/story-icon.png" , height: 80,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(child: Text(story.title , overflow: TextOverflow.ellipsis,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(child: Text(story.category),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(story.language, overflow: TextOverflow.ellipsis, ),
                        )
                      ],),
                    ),
                  ],
                )),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => StoryDetails.story(story.id,story)));
            },
          );
          storyWidgetsList.add(storyWidget);
        });

        // storyList.add(story);
      }

      setState(() {
        Stories = GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: storyWidgetsList,
        );
      });

    }));
  }


  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // screenSizeFetched = true;

    refreshData();

    // dummyGridView = GridView.count(
    //   scrollDirection: Axis.vertical,
    //   crossAxisCount: 2,
    //   shrinkWrap: true,
    //   children: [
    //     Card(
    //         child: Container(
    //           height: 200,
    //           width: screenWidth,
    //           child: Column(children: [
    //             Center(
    //               child: Stack(children: [
    //                 Image.asset("assets/images/story-icon.png" , height: 100,),
    //                 Positioned(
    //                   child: Container(
    //                     color: Colors.white,
    //                     child: Text(
    //                       "3",
    //                     ),
    //                   ),
    //                   bottom: 0,
    //                   right: 0,
    //                 ),
    //               ],),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Center(child: Text("story title"),),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text("story category"),
    //                   Text("story language")
    //                 ],),
    //             )
    //           ],),
    //         )),
    //     Card(
    //         child: Container(
    //           height: 200,
    //           width: screenWidth,
    //           child: Column(children: [
    //             Center(
    //               child: Stack(children: [
    //                 Image.asset("assets/images/story-icon.png" , height: 100,),
    //                 Positioned(
    //                   child: Container(
    //                     color: Colors.white,
    //                     child: Text(
    //                       "3",
    //                     ),
    //                   ),
    //                   bottom: 0,
    //                   right: 0,
    //                 ),
    //               ],),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Center(child: Text("story title"),),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text("story category"),
    //                   Text("story language")
    //                 ],),
    //             )
    //           ],),
    //         )),
    //     Card(
    //         child: Container(
    //           height: 200,
    //           width: screenWidth,
    //           child: Column(children: [
    //             Center(
    //               child: Stack(children: [
    //                 Image.asset("assets/images/story-icon.png" , height: 100,),
    //                 Positioned(
    //                   child: Container(
    //                     color: Colors.white,
    //                     child: Text(
    //                       "3",
    //                     ),
    //                   ),
    //                   bottom: 0,
    //                   right: 0,
    //                 ),
    //               ],),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Center(child: Text("story title"),),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text("story category"),
    //                   Text("story language")
    //                 ],),
    //             )
    //           ],),
    //         )),
    //     Card(
    //         child: Container(
    //           height: 200,
    //           width: screenWidth,
    //           child: Column(children: [
    //             Center(
    //               child: Stack(children: [
    //                 Image.asset("assets/images/story-icon.png" , height: 100,),
    //                 Positioned(
    //                   child: Container(
    //                     color: Colors.white,
    //                     child: Text(
    //                       "3",
    //                     ),
    //                   ),
    //                   bottom: 0,
    //                   right: 0,
    //                 ),
    //               ],),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Center(child: Text("story title"),),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text("story category"),
    //                   Text("story language")
    //                 ],),
    //             )
    //           ],),
    //         )),
    //   ],
    // );

    return Scaffold(

      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home-bg.png"),
                fit: BoxFit.cover
            )
        ),
        child: _bodyWidget,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF0DB4EA),
          currentIndex: _bottomNavigationBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.userAlt), title: Text("Profile") ),
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home") ),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.signOutAlt), title: Text("Logout") ),
          ]),

    );
  }







}

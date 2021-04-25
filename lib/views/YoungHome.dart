import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../Global.dart';
import 'StoryDetails.dart';
import '../models/UserStory.dart';
import 'SearchYoung.dart';
class YoungHome extends StatefulWidget {
  @override
  _YoungHomeState createState() => _YoungHomeState();
}

class _YoungHomeState extends State<YoungHome> {

  double screenHeight;
  double screenWidth;
  bool initialBody = true;
  Widget _bodyWidget;
  List<Widget> storyWidgetsList = [];
  Widget Stories;
  Widget dummyGridView;

  final TextEditingController _searchController = TextEditingController();


  _YoungHomeState(){
    getStories();
  }
  refreshData(){

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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SearchPage()),
                                      );
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
          storyWidgetsList.length > 0 ? Stories : Text(" No Stories to display "),

        ],
      ),
    );
  }

  getStories() {
    FirebaseFirestore.instance
        .collection("UserStory")
        .snapshots()
        .listen((documentSnapshot) => setState((){

      storyWidgetsList = [];

      for(QueryDocumentSnapshot fireBaseDocument in  documentSnapshot.docs){
        UserStory userstory = new UserStory();
        userstory.id = fireBaseDocument.id;
        userstory.title = fireBaseDocument.data()["Title"];
        userstory.category = fireBaseDocument.data()["Category"];
        userstory.language = fireBaseDocument.data()["Language"];
        userstory.educationalLevel = fireBaseDocument.data()["EducationLevel"];

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
                            userstory.educationalLevel.toString(),
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
                          child: Center(child: Text(userstory.title , overflow: TextOverflow.ellipsis,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(child: Text(userstory.category),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(userstory.language, overflow: TextOverflow.ellipsis, ),
                        )
                      ],),
                    ),
                  ],
                )),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => StoryDetails.userstory(userstory.id,userstory)));
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
    refreshData();

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

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,
              '/NewStory');
          // getOCRData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
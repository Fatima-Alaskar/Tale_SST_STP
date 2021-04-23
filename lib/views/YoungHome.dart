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
import '../models/UserStory.dart';
import 'SearchYoung.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  // _HomePageState()  {
  //   refreshData();
  // }

  _HomePageState(){
    getStories();
  }

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
                                prefixIcon: IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(
                                    Icons.search,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SearchYoung()),
                                    );
                                  },
                                ),

                                //Icon(Icons.search), TODO: instead of Icon button.
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
            UserStory story = new UserStory();
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
                      MaterialPageRoute(builder: (BuildContext context) => StoryDetails.Userstory(story.id,story)));
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
          // selectedLabelStyle: TextStyle(color: Colors.white),
          // unselectedLabelStyle: TextStyle(color: Color(0xFF556036)),
          backgroundColor: Color(0xFF0DB4EA),

          onTap: (int tabIndex){
            selectTap(tabIndex);

          },
          currentIndex: _bottomNavigationBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.userAlt), title: Text("Profile") ),
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home") ),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.signOutAlt), title: Text("Logout") ),
          ]),
      floatingActionButton: tabindex != 1 ? null : FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,
              '/NewStory');
          // getOCRData();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  selectTap(int tabIndex){
    tabindex = tabIndex;
    setState(() {

      _bottomNavigationBar = tabIndex;


      switch (tabIndex) {
        case 0 :
          getBodyToProfilePage();
          break;
        case 1:
          getBodyToHomePage();
          break;
        case 2:
          getBodyToLogout();
          break;
        default :
          getBodyToHomePage();
          break;
      }

    });
  }

  getBodyToProfilePage(){
    setState(() {
      initialBody = false;
      String username =  Global.auth.currentUser.email.toString().substring(0,Global.auth.currentUser.email.toString().indexOf('@')); // Global.auth.currentUser.email.toString().indexOf('@').toString();

      _bodyWidget =
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 200,),
                  Icon(Icons.account_circle, size: 80,),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Form(
                          // key: _searchFormKey,
                          child: Row(
                            children: [

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
                                      enabled: false,
                                      labelText: username,
                                    ),
                                    // style: TextStyle(
                                    //     color: Colors.white, decorationColor: Colors.white),
                                    cursorColor: Color(0xFF556036),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });

  }

  getBodyToHomePage(){
    setState(() {
      initialBody = true;

      refreshData();

      // _bodyWidget =
      // SingleChildScrollView(
      //   child: Container(
      //     child: Column(
      //       children: [
      //         Column(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(20.0),
      //               child: Row(
      //                 children: [
      //                   Form(
      //                     // key: _searchFormKey,
      //                     child: Row(
      //                       children: [
      //                         SizedBox(height: 250,),
      //                         Container(
      //                           // color: Colors.white,
      //                           // height: 50,
      //                           width: screenWidth - 40,
      //                           decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(5),color: Colors.white
      //                           ),
      //                           child: Padding(
      //                             padding: const EdgeInsets.only(left: 8),
      //                             child: TextFormField(
      //                               controller: _searchController,
      //
      //                               decoration: InputDecoration(
      //                                 border: InputBorder.none,
      //                                 focusedBorder: InputBorder.none,
      //                                 enabledBorder: InputBorder.none,
      //                                 errorBorder: InputBorder.none,
      //                                 disabledBorder: InputBorder.none,
      //                                 labelText: 'Search',
      //                                 prefixIcon: Icon(Icons.search),
      //                                 suffix: Container(
      //                                   height: 30,
      //                                   child: Padding(
      //                                     padding: const EdgeInsets.only(right: 8.0),
      //                                     child: RaisedButton(child: Text("Search"),onPressed: (){
      //                                       //
      //                                     }),
      //                                   ),
      //                                 ),
      //                               ),
      //                               cursorColor: Color(0xFF556036),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // );
    });

  }

  getBodyToLogout(){

    Global.auth.signOut();

    SchedulerBinding.instance.addPostFrameCallback((_) {

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/LoginPage', (Route<dynamic> route) => false);
    });

  }


}

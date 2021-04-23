// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   double screenHeight;
//   double screenWidth;
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         body: Container(
//           height: screenHeight,
//           width: screenWidth,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/images/home-bg.png"),
//                   fit: BoxFit.cover
//               )
//           ),
//         )
//     );
//   }
// }
//
//



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Global.dart';
import '../models/Story.dart';
import 'StoryDetails.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int _bottomNavigationBar = 1;
  int tabindex = 1;
  Widget _bodyWidget;
  bool initialBody = true;
  List<Widget> storyWidgetsList = [];

  Widget Stories;

  double screenHeight;
  double screenWidth;

  final TextEditingController _searchController = TextEditingController();
  //
  // // _HomePageState()  {
  // //   refreshData();
  // // }
  //
  // _HomePageState(){
  //   getStories();
  // }

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

  // getStories() {
  //   FirebaseFirestore.instance
  //       .collection('Story')
  //       .snapshots()
  //       .listen((documentSnapshot) => setState((){
  //
  //     storyWidgetsList = [];
  //
  //     for(QueryDocumentSnapshot fireBaseDocument in  documentSnapshot.docs){
  //       Story story = new Story();
  //       story.id = fireBaseDocument.id;
  //       story.title = fireBaseDocument.data()["Title"];
  //       story.category = fireBaseDocument.data()["Category"];
  //       story.language = fireBaseDocument.data()["Language"];
  //       story.educationalLevel = fireBaseDocument.data()["EducationLevel"];
  //
  //       setState(() {
  //         Widget storyWidget = GestureDetector(
  //           child: Card(
  //               child: Stack(
  //                 children: [
  //                   Positioned(
  //                     child: Container(
  //                       color: Colors.white,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Text(
  //                           story.educationalLevel.toString(),
  //                         ),
  //                       ),
  //                     ),
  //                     top: 0,
  //                     right: 0,
  //                   ),
  //                   Container(
  //                     height: 225,
  //                     width: screenWidth,
  //                     child: Column(children: [
  //                       Center(
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(top: 8),
  //                           child: Image.asset("assets/images/story-icon.png" , height: 80,),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 8),
  //                         child: Center(child: Text(story.title , overflow: TextOverflow.ellipsis,),),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 8),
  //                         child: Center(child: Text(story.category),),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 8),
  //                         child: Text(story.language, overflow: TextOverflow.ellipsis, ),
  //                       )
  //                     ],),
  //                   ),
  //                 ],
  //               )),
  //           onTap: (){
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (BuildContext context) => StoryDetails.story(story.id,story)));
  //           },
  //         );
  //         storyWidgetsList.add(storyWidget);
  //       });
  //
  //       // storyList.add(story);
  //     }

  //     setState(() {
  //       Stories = GridView.count(
  //         scrollDirection: Axis.vertical,
  //         crossAxisCount: 2,
  //         shrinkWrap: true,
  //         children: storyWidgetsList,
  //       );
  //     });
  //
  //   }));
  // }

  User user;
  @override
  void initState() {
    super.initState();
    initUser(); }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {}); }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_rounded),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {} ,
          ),
        ],

      ),
      body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Profile +logout.png"),
                  fit: BoxFit.cover
              )
          ),
          child: ListView(children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "${user?.displayName}",
                textAlign: TextAlign.center,
              ),
              accountEmail: Text(
                "${user?.email}",
                textAlign: TextAlign.right,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  user.displayName.characters.first,
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  //image: NetworkImage("${user?.photoUrl}"),
                ),
              ),
            ),

          ]


          )
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
       //TODO: //  getBodyToHomePage();
          break;
        case 2:
        //  getBodyToLogout();
          break;
      }

    });
  }

  getBodyToProfilePage(){
    setState(() {
      initialBody = true;
      // refreshData();
      //   String username =  Global.auth.currentUser.email.toString().substring(0,Global.auth.currentUser.email.toString().indexOf('@')); // Global.auth.currentUser.email.toString().indexOf('@').toString();
      //
      //   _bodyWidget =
      //       SingleChildScrollView(
      //         child: Container(
      //           child: Column(
      //             children: [
      //               Column(
      //                 children: [
      //                   SizedBox(height: 200,),
      //                   Icon(Icons.account_circle, size: 80,),
      //                   SizedBox(height: 50,),
      //                   Padding(
      //                     padding: const EdgeInsets.all(20.0),
      //                     child: Row(
      //                       children: [
      //                         Form(
      //                           // key: _searchFormKey,
      //                           child: Row(
      //                             children: [
      //
      //                               Container(
      //                                 width: screenWidth - 40,
      //                                 decoration: BoxDecoration(
      //                                     borderRadius: BorderRadius.circular(5),color: Colors.white
      //                                 ),
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(left: 8),
      //                                   child: TextFormField(
      //                                     controller: _searchController,
      //                                     decoration: InputDecoration(
      //                                       border: InputBorder.none,
      //                                       focusedBorder: InputBorder.none,
      //                                       enabledBorder: InputBorder.none,
      //                                       errorBorder: InputBorder.none,
      //                                       disabledBorder: InputBorder.none,
      //                                       enabled: false,
      //                                       labelText: username,
      //                                     ),
      //                                     // style: TextStyle(
      //                                     //     color: Colors.white, decorationColor: Colors.white),
      //                                     cursorColor: Color(0xFF556036),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //     );
    });

  }





}
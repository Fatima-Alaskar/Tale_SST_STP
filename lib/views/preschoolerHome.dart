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
import 'ViewStory.dart';
import 'StoryInside.dart';
import 'SearchStory.dart';

class PreShooler extends StatefulWidget {
  @override
  _PreShoolerState createState() => _PreShoolerState();
}

class _PreShoolerState extends State<PreShooler> {

  double screenHeight;
  double screenWidth;

  final TextEditingController _searchController = TextEditingController();



  Widget build(BuildContext context) {
          screenHeight = MediaQuery
              .of(context)
              .size
              .height;
          screenWidth = MediaQuery
              .of(context)
              .size
              .width;

          return Scaffold(
              resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Center(child: Text('Preschooler Library')),
              actions: <Widget>[
              IconButton(
              alignment: Alignment.center,
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),],),
              body: SingleChildScrollView(
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/home-bg.png"),
                          fit: BoxFit.cover
                      )

                  ),

                  child: Column(
                    children: [

                      StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Story')
                          .snapshots(),
                      builder: (context, snapshots) {
                        if (snapshots.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Text("");
                        }
                        return Container(
                          child: GridView.builder(
                              gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                              shrinkWrap: true,
                              itemCount: snapshots.data.docs.length,
                              //snapshots.data.documents.length,
                              itemBuilder: (context, index) {
                                //DocumentSnapshot documentSnapshot=snapshots.data;
                                return Container(
                                  child: Dismissible(

                                    onDismissed: (direction) {
                                      AbsorbPointer(absorbing: false);
                                    },
                                    key: Key(index.toString()),

                                    child: Container(
                                      child: InkWell(
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              AspectRatio(
                                                aspectRatio: 18.0 / 11.0,
                                                child: Image.network(

                                                          snapshots.data.docs[index]["img"],
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(snapshots.data.docs[index]["Title"],),
                                                    SizedBox(height: 8.0),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                    ),
                                        onTap: () {
                                          print(snapshots.data[index].toString());
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewStory(snapshots.data[index].toString())),
                                          );
                                        },                                      ),
                                  //   child: Card(
                                  //     elevation: 4,
                                  //     margin: EdgeInsets.all(8),
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(8)),
                                  //
                                  //
                                  //     child: ListTile(
                                  //       title: Text(
                                  //         snapshots.data.docs[index]["Title"],
                                  //
                                  //       ),
                                  //       /*trailing: IconButton(
                                  //   icon: Icon(Icons.delete),
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       shoppingList.removeAt(index);
                                  //       updateList();
                                  //     });
                                  //   },
                                  // ),*/
                                  //       leading: Image.network(
                                  //
                                  //         snapshots.data.docs[index]["img"],
                                  //       ),

                                  //     ),
                                  //   ),
                                  ),
                                ),);
                              }),
                        ); //}
                        //return Text("add something");
                      }),
                    ],
                  ),

                ),
              )
          );
        }


      }
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


class Storys extends StatefulWidget {
  @override
  _StorysState createState() => _StorysState();
}

class _StorysState extends State<Storys> {

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
              body: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/home-bg.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: StreamBuilder(
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
                      return GridView.builder(
                          gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          shrinkWrap: true,
                          itemCount: snapshots.data.documents.length,
                          itemBuilder: (context, index) {
                            //DocumentSnapshot documentSnapshot=snapshots.data;
                            return Dismissible(

                              onDismissed: (direction) {
                                AbsorbPointer(absorbing: false);
                              },
                              key: Key(index.toString()),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  title: Text(
                                    snapshots.data["Title"][index],
                                    textAlign: TextAlign.right,
                                  ),
                                  /*trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  shoppingList.removeAt(index);
                                  updateList();
                                });
                              },
                            ),*/
                                  trailing: Image.network(
                                    snapshots.data["img"][index].Images,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryInside()),
                                    );
                                  },
                                ),
                              ),
                            );
                          }); //}
                      //return Text("add something");
                    }),

              )
          );
        }


      }
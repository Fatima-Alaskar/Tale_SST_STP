import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../tale_teller_/lib/views/ViewStory.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class Prescooler extends StatefulWidget {
  @override
  _PrescoolerState createState() => _PrescoolerState();
}

class _PrescoolerState extends State<Prescooler> {
  FirebaseAuth user;
  double screenHeight;
  double screenWidth;
  CollectionReference stories = FirebaseFirestore.instance.collection('Story');
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
          child:StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Story').snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return Text("");
                }
                return GridView.builder(
                    gridDelegate:
                    new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    shrinkWrap: true,
                    itemCount: snapshots.data["list"].length,
                    itemBuilder: (context, index) {
                      //DocumentSnapshot documentSnapshot=snapshots.data;
                      return Dismissible(

                        onDismissed: (direction) {
                          AbsorbPointer(absorbing: false) ;
                        },
                        key: Key(index.toString()),
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Text(
                              snapshots.data["title"][index],
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
                                MaterialPageRoute(builder: (context) => ViewStory()),
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
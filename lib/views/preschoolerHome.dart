import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Global.dart';
import '../models/Story.dart';
import 'StoryDetails.dart';
import 'ViewStory.dart';
import 'StoryInside.dart';
import 'SearchStory.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;

class PreShooler extends StatefulWidget {
  @override
  _PreShoolerState createState() => _PreShoolerState();
}

class _PreShoolerState extends State<PreShooler> {

  double screenHeight;
  double screenWidth;
  List FavList = new List();
  User user;

  void initState() {
    super.initState();
    initUser(); }

  initUser() async {
    user = await _auth.currentUser;
    await firestoreInstance.collection("FavoriteList").doc(user?.uid).get().then((value) {
      setState(() {
        FavList.addAll(value.data()["list"]);
      });
    });
  }

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

                StreamBuilder<QuerySnapshot>(
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
                              DocumentSnapshot documentSnapshot=snapshots.data.docs[index];
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

                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    snapshots.data.docs[index]["img"],
                                                      fit: BoxFit.fill
                                                  ),
                                              Positioned(
                                                  top: 1, right: 1,
                                                  child:  IconButton(
                                                    icon: (FavList.contains(documentSnapshot.reference.id.toString()))
                                                        ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )
                                                        : Icon(
                                                      Icons.favorite_border,
                                                    ),
                                                    // add to favorite list
                                                    onPressed: () {
                                                      setState(() {
                                                        (FavList.contains(documentSnapshot.reference.id.toString()))
                                                            ? FavList.removeAt(FavList.indexOf(
                                                            documentSnapshot.reference.id.toString()))
                                                            : FavList.add(documentSnapshot.reference.id.toString());
                                                        // update favorite list in firbase
                                                        updateFav();
                                                      });
                                                    }, //  Icons.favorite_border,
                                                  ),

                                            ),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    snapshots.data.docs[index]["Title"],
                                                    style: TextStyle(
                                                      fontSize: 10.0,),
                                                  ),



                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),
                                      onTap: () {
                                        print(documentSnapshot.reference.id.toString()
                                            + "++++++++++++++++++++++++++++++");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewStory(documentSnapshot.reference.id.toString())),
                                        );
                                      },                                      ),

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
  void updateFav() {
    DocumentReference documentReference =
    firestoreInstance.collection("FavoriteList").doc(user?.uid);
    //map
    Map<String, dynamic> mylist = {"list": FavList};
    documentReference.set(mylist).whenComplete(() {});
  }

}
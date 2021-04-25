import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tale_teller/models/Story.dart';

final firestoreInstance = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}
//
class _FavoriteState extends State<Favorite> {
  User user;
  double screenHeight;
  double screenWidth;

  List favList = List();
  List<Story> dataList = [];
  String message = "";
  Story data;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {
    });
    await firestoreInstance.collection("FavoriteList").doc(user?.uid).get().then((value) {
      setState(() {
        favList.addAll(value.data()["list"]);
        initData();
      });
    });
  }

  initData() async {
    if (favList.isEmpty) {
      setState(() {
        Text("You didn't favorite any story");
      });
    }
    for (var i = 0; i < favList.length; i++) {
      FirebaseFirestore.instance.collection('Story').doc(favList[i].toString()).get().then((value) {
        setState(() {
          data = new Story(
            favList[i].toString(),
            value["Title"],
            value["img"],
          );
          dataList.add(data);

        });
      });
    }
  }

  updateList() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("FavoriteList").doc(user?.uid);
    //map
    Map<String, dynamic> mylist = {"list": favList};
    documentReference.set(mylist).whenComplete(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text('Favorite list',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF0DB4EA) ,
      ),
      body:  dataList.length == 0
          ? Center(
          child: Text("Nothing in your favorite list ",
              style: TextStyle(fontSize: 20)))
          : ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (_, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              elevation: 2,
              margin: EdgeInsets.all(10),
              child: ListTile(
                  title: Text(
                    dataList[index].title,
                    textAlign: TextAlign.right,
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      setState(() {
                        favList.removeAt(index);
                        dataList.removeAt(index);
                        updateList();
                      });
                    },
                  ),
                  trailing: Image.network(
                    dataList[index].image,
                  )),
            );
          }),
    );
  }

}
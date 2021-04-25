import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ViewStory.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0DB4EA) ,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search'),
            onSubmitted: (val) {
              setState(() {
                title = val;
                print (val);

              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (title != "" && title != null)
            ? FirebaseFirestore.instance
            .collection('Story')
            .where( "Title",isEqualTo: title)
            .snapshots()
            : FirebaseFirestore.instance.collection("Story").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())

              : ListView.builder(
             itemCount: snapshot.data.docs.length,
             itemBuilder: (context, index) {
               DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
               return Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
              child: ListTile(
              title: Text(
                snapshot.data.docs[index]["Title"], // The crrect..
              textAlign: TextAlign.right,
              ),

              trailing: Image.network(
              snapshot.data.docs[index]["img"],
              ),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => ViewStory(documentSnapshot.reference.id.toString())),
              );
              },
              ),
              );
            },
          );
        },
      ),
    );
  }

}
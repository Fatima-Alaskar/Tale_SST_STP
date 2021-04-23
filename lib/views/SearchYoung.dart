import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ViewStory.dart';
import 'StoryInside.dart';


class SearchYoung extends StatefulWidget {
  @override
  _SearchYoungState createState() => _SearchYoungState();
}

class _SearchYoungState extends State<SearchYoung> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (title != "" && title != null)
            ? FirebaseFirestore.instance
            .collection("UserStory")
            .where("searchKeywords", arrayContains: title)
            .snapshots()
            : FirebaseFirestore.instance.collection("UserStory").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(
                    snapshot.data.docs[index]["Title"],
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
                    snapshot.data.docs[index]["img"],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoryInside()),
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

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'preschoolerHome.dart';
// import 'NavigationBar.dart';
// import 'package:tale_teller/models//Story.dart';
//
//
// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> {
//   bool searchState = false;
//   String message;
//
//   List Storeies= new List();
//
//   @override
//   void initState() {
//     super.initState();
//     message = " Search for story ";
//     Storeies.clear();
//     //initUser();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar:AppBar(
//             title: Text("Search"),
//             leading:
//             TextField(
//             decoration: InputDecoration(
//               icon: Icon(Icons.search),
//               hintText: "Search",
//               hintStyle: TextStyle(color: Colors.white),
//             ),
//             onSubmitted: (text) {
//               SearchMethod(text);
//             },
//           ),
//
//           ),
//         body: Storeies.length == 0
//             ? Center(
//             child: Text(
//               message,
//               style: TextStyle(fontSize: 30),
//             ))
//             : ListView.builder(
//             itemCount: Storeies.length,
//             itemBuilder: (_, index) {
//               return Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 color: Colors.white,
//                 elevation: 2,
//                 margin: EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(
//                     Storeies[index].Title,
//                   ),
//
//                   trailing: Image.network(
//                     Storeies[index].Img,
//                   ),
//                 ),
//               );
//             }),
//         endDrawer: NavigationBar());
//   }
//
//   void SearchMethod(String text) {
//     setState(() {
//     });
//
//     FirebaseFirestore.instance
//         .collection("Story")
//         .snapshots().{
//
//       DatabaseReference searchRef = FirebaseDatabase.instance.reference();
//     searchRef.once().then((DataSnapshot snapShot) {
//       var values = snapShot.value;
//       for (var i = 0; i < snapShot.value.length; i++) {
//         double o = 0.0;
//         if (values[i]["Offer"].toDouble() != null) {
//           o = values[i]["Offer"].toDouble();
//         }
//         Product data = new Product(
//           values[i]["Images"],
//           values[i]["Name"],
//           values[i]["stock"],
//           o,
//           values[i]["Category"],
//           values[i]["Brand"],
//           values[i]["Price"].toDouble(),
//           values[i]["aisle"],
//         );
//         data.id = i.toString();
//         if (data.Name.contains(text)) {
//           setState(() {
//             dataList.add(data);
//             loading = false;
//           });
//         }
//       }
//       if (dataList.length == 0) {
//         setState(() {
//           loading = false;
//           message = "لا توجد نتائج";
//         });
//       }
//     });
//   }
//
//   void updateFav() {
//     DocumentReference documentReference =
//     Firestore.instance.collection("Favorite").document(user?.uid);
//     //map
//     Map<String, dynamic> mylist = {"list": FavList};
//     documentReference.setData(mylist).whenComplete(() {});
//   }
// }
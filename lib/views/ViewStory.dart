import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:audioplayer/audioplayer.dart';
//import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ViewStory extends StatefulWidget {
 final String id;



 ViewStory (this.id);
  @override
  _ViewStoryState createState() => _ViewStoryState( this.id);
}

class _ViewStoryState extends State<ViewStory> {
  _ViewStoryState(this.id);
  AudioPlayer audioPlugin = AudioPlayer();
  bool _isLoading = true;
  PDFDocument document;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double screenHeight;
  double screenWidth;
  String id;
  int LScore;



  String PDF;
  String audio;
  int count;
  int word;
  bool seekDone;
  bool player=false;
  User user;


  @override
  void initState() {
  super.initState();
  loadDocument();


  super.initState();

  }

  loadDocument() async {
   await FirebaseFirestore.instance.collection('Story').doc(id.toString()).get().then((value) {

     setState(() {
        PDF=value.data()["Story"];
        audio=value.data()["Audio"];
        word=int.parse(value.data()["NumberOfWords"]);
      });
    });
   document = await PDFDocument.fromURL(
       PDF);
    setState(() => _isLoading = false);
   calScore();
  }

calScore() async{
    print(word.toString()+"wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
  user = await _auth.currentUser;
  await FirebaseFirestore.instance.collection('listeningScore').doc(user.uid.toString()).get().then((value){
    setState(() {
      count=int.parse(value.data()['Score'].toString());
    });
  });
    print(count.toString()+"ccccccccccccccccccccccccccccccccccccccc");
    // String w = word+count;
  await FirebaseFirestore.instance.collection('listeningScore').doc(user.uid).update({'Score': word+count,
  });
}

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0DB4EA) ,
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
        title: Text("View Story"),
        actions: [
          IconButton(
          icon:
            (!player)? Icon(Icons.play_arrow):Icon(Icons.pause),
            onPressed: (
                ) {
              if (!player) {
                audioPlugin.play(audio);
                setState(() {
                  player = true;
                });}
              else {audioPlugin.pause();
              setState(() {
                player = false;
              });}},
          ),
        ],
        centerTitle: true,
      ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(

                height: screenHeight,
                width: screenWidth,

                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/home-bg.png"),
                        fit: BoxFit.cover
                    ),
                ),
                child:
                Center(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : PDFViewer(document: document)),

                          ),





            ],

          ),

        ),
              ); //}
  }
}

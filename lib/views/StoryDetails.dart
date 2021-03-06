import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/UserStory.dart';

import 'StoryPage.dart';

class StoryDetails extends StatefulWidget {
  String storyID;
  UserStory currentStory;


  StoryDetails.userstory(String storyID, UserStory currentStory){

    this.storyID = storyID;
    this.currentStory = currentStory;
  }


  @override
  _StoryDetailsState createState() =>  _StoryDetailsState.userstory(storyID, currentStory);
}

class _StoryDetailsState extends State<StoryDetails> {

  double screenHeight;
  double screenWidth;

  String storyID;
  UserStory currentStory;
  String ocrText = "";

  List<Widget> lines = new List();
  Widget body;

  List<Widget> storyPageWidgetsList = [];

  Widget StoryPages;

  _StoryDetailsState.userstory(String storyID, UserStory currentStory){
    this.storyID = storyID;
    this.currentStory = currentStory;

    getStoryInfo();

  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // print("story object: " +currentStory.title);
    String title = "Story Details - " + currentStory.title ;

    if (lines.length < 1){
      lines.add(Text(" "));
    }

    if (body == null || storyPageWidgetsList.length < 1){
      body = Center(
        child: Text("Please add Pages"),
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text(title),
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getOCRData();
        },
        tooltip: 'Get Text', //long pressed
        child: Icon(Icons.add),
      ),
    );
  }

  File imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  getOCRData() async {

    await getImage();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);

    ocrText = ocrText + visionText.text;


    String lineText = "";
      //TODO:
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;


      for (TextLine line in block.lines) {
        lineText = lineText + " ";
        for (TextElement element in line.elements) {
          lineText = lineText + " " + element.text;
        }

      }

    }

    saveStoryPageText(lineText);

  }
  getStoryInfo() {
    FirebaseFirestore.instance.collection("UserStory").doc(currentStory.id).collection('pages').snapshots()
        .listen((documentSnapshot) => setState((){

        int pageNumber = 0;
        storyPageWidgetsList = [];
      for(QueryDocumentSnapshot fireBaseDocument in  documentSnapshot.docs){
        pageNumber++;
        String storyPageText = fireBaseDocument.data()["storyPageText"];

        setState(() {
          Widget storyPageWidget = GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // width: screenWidth,
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: Color(0xFF185366),
                          child: Center(child: Text(pageNumber.toString(), style: TextStyle(color: Colors.white),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: Container(child: Text(storyPageText,overflow: TextOverflow.ellipsis,),width: screenWidth - 90,),
                        )
                      ],
                    ),
                ),
              ),
            ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) => StoryPage.userstory(fireBaseDocument.id,currentStory)));
                },
          );
          storyPageWidgetsList.add(storyPageWidget);
        });

      }

      setState(() {
        StoryPages = GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 1,
          shrinkWrap: true,
          children: storyPageWidgetsList,
        );

        body = Column(
          children: storyPageWidgetsList,
        );

      });

    }));
  }

  saveStoryPageText(String storyPageText){
    final collRef = FirebaseFirestore.instance.collection("UserStory").doc(currentStory.id).collection('pages');
    DocumentReference documentReference = collRef.doc();


    documentReference.set({
      'storyPageText': storyPageText.toString()
    }).whenComplete(() => {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => StoryDetails.userstory(documentReference.id,currentStory))),

    });
  }

}

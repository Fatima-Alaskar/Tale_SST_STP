import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ViewStory extends StatefulWidget {
 final String id;
 // final AudioPlayer advancedPlayer;


 ViewStory (this.id);
  @override
  _ViewStoryState createState() => _ViewStoryState( this.id);
}

class _ViewStoryState extends State<ViewStory> {
  _ViewStoryState(this.id);
  bool _isLoading = true;
  PDFDocument document;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double screenHeight;
  double screenWidth;
  String id;
  int LScore;

  // PDFDocument document;

  String PDF;
  String audio;

  bool seekDone;


  // AudioCache audioCache = AudioCache();
  // AudioPlayer advancedPlayer = AudioPlayer();


  @override
  void initState() {
  super.initState();
  loadDocument();

  // widget.advancedPlayer.onSeekComplete
  //     .listen((event) => setState(() => seekDone = true));
  super.initState();

  }

  loadDocument() async {
   await FirebaseFirestore.instance.collection('Story').doc(id.toString()).get().then((value) {

     setState(() {
        PDF=value.data()["Story"];
        //audio=value.data()["Audio"];

      });
    });
   document = await PDFDocument.fromURL(
       PDF);

   // // document = await PDFDocument.fromURL(
   // //     "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
   // //      cacheManager: CacheManager(
   // //        Config(
   // //          "customCacheKey",
   // //          stalePeriod: const Duration(days: 2),
   // //          maxNrOfCacheObjects: 10,
   // //        ),
   //      ), );

    setState(() => _isLoading = false);
  }


  // Future _loadFile() async {
  //   //final bytes = await readBytes(Uri.parse(kUrl1));
  //   await file.writeAsBytes(bytes);
  //   if (await file.exists()) {
  //     setState(() => localFilePath = file.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
        title: Text("View Story"),
        centerTitle: true,
      ),

        body: SingleChildScrollView(
          child: Container(

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
        ),
              ); //}
  }
}

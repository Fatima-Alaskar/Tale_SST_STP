import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:image_picker/image_picker.dart';

import '../models/UserStory.dart';
class StoryPage extends StatefulWidget {
  String storyPageID;
  UserStory currentStory;


  StoryPage.userstory(String storyID, UserStory currentStory){
    this.storyPageID = storyID;
    this.currentStory = currentStory;
  }

  @override
  _StoryPageState createState() => _StoryPageState.userstory(storyPageID, currentStory);
}

enum TtsState { playing, stopped, paused, continued }

class _StoryPageState extends State<StoryPage> {

  double screenHeight;
  double screenWidth;

  String storyPageID;
  UserStory currentStory;

  String pageText = " ";
  String sstText = " ";

  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  int resultListened = 0;

  bool speaking = false;

  int sstStatus = 0;

  stt.SpeechToText speech = stt.SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;

  _StoryPageState.userstory(String storyID, UserStory currentStory){
    this.storyPageID = storyID;
    this.currentStory = currentStory;

    getStoryInfo(); }


  @override
  Widget build(BuildContext context) {

    String title = "Story Details - " + currentStory.title ;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: new AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              height: (screenHeight-100)/2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Main Story Content", style: TextStyle(fontSize: 20),),

                      ],),
                  ),
                  Divider(color: Colors.grey, height: 3,),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text(pageText, softWrap: true,), width: screenWidth - 20,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              height: (screenHeight-100)/2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Speech To Text Content", style: TextStyle(fontSize: 20),),

                      ],),
                  ),
                  Divider(color: Colors.grey, height: 3,),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text(sstText, softWrap: true,), width: screenWidth - 20,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: sstStatus == 0 ?

      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          !speaking ? FloatingActionButton(
            onPressed: (){
              _speak();
              setState(() {
                speaking = true;
              });
            },
            tooltip: 'Text to Speech',
            child: Icon(Icons.record_voice_over),
          ): FloatingActionButton(
            onPressed: (){
              _stopSpeaking();
              setState(() {
                speaking = false;
              });
            },
            tooltip: 'Text to Speech',
            child: Icon(Icons.close),
          ) ,
          SizedBox(height: 10,),
          !speaking? FloatingActionButton(
            onPressed: (){
              startSTT();
              setState(() {
                sstStatus = 1;
              });
            },
            tooltip: 'Speech to text',
            child: Icon(Icons.mic),
          ): SizedBox(),
        ],
      ) : FloatingActionButton(
        onPressed: (){
          stopSTT();
          setState(() {
            sstStatus = 0;
          });
        },
        tooltip: 'Speech to text',
        child: Icon(Icons.close),
      ),
    );
  }

  getStoryInfo() async {

    String text;

    await FirebaseFirestore.instance
        .collection("UserStory")
        .doc(currentStory.id)
        .collection('pages').doc(storyPageID).get()
        .then((value) => {
      text = value.data()["storyPageText"],
    });

    setState(() {
      pageText = text;
    });

  }

  startSTT() async{

    bool available = await speech.initialize( onStatus: statusListener, onError: errorListener );
    if ( available ) {
      speech.listen( onResult: resultListener );
    }
    else {
      print("The user has denied the use of speech recognition.");
    }
    // some time later...
    // speech.stop();
  }

  stopSTT(){
    speech.stop();
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = '$status';
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
      sstText = result.recognizedWords ;//+ result.recognizedWords;
    });
  }


  Future _speak() async {
    if (pageText != null) {
      if (pageText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(pageText);
      }
    }
  }

  Future _stopSpeaking() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

}
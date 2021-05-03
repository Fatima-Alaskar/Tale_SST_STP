import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../models/UserStory.dart';

import 'StoryDetails.dart';

class NewStory extends StatefulWidget {
  @override
  _NewStoryState createState() => _NewStoryState();
}

class _NewStoryState extends State<NewStory> {
  double screenHeight;
  double screenWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _educationLevelController =
      TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: new AppBar(
        title: Text("Add Story"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login-bg.png"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  controller: _titleController,
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'Ops! Enter title';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelText: 'Story Title',
                                  ),
                                  cursorColor: Color(0xFF556036),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  controller: _categoryController,
                                  // obscureText: true,
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'Ops! Enter category';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelText: 'Story Category',
                                  ),
                                  cursorColor: Color(0xFF556036),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextFormField(
                                      controller: _languageController,
                                      // obscureText: true,
                                      validator: (String value) {
                                        if (value.isEmpty)
                                          return 'Ops! Enter the language of the story';
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        labelText: 'Story Language',
                                      ),
                                      cursorColor: Color(0xFF556036),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: screenWidth / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: TextFormField(
                                        controller: _educationLevelController,
                                        validator: (String value) {
                                          if (value.isEmpty)
                                            return 'Ops! enter educational level';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          labelText: 'Educational Level',
                                        ),
                                        cursorColor: Color(0xFF556036),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: screenWidth / 3 * 2,
                      height: 50,
                      child: RaisedButton(
                          child: Text(
                            "Add Story",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          color: Color(0xFF185366),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await addStory();
                            }
                          }),
                    ),
                  ),
                  bottom: 120,
                  left: 0),
            ],
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  addStory() {
    var eduLevel;
    try {
      eduLevel = int.parse(_educationLevelController.text);
    } catch (e) {
      print(e);
    }

    UserStory currentStory = new UserStory();
    currentStory.title = _titleController.text;
    currentStory.category = _categoryController.text;
    currentStory.language = _languageController.text;
    currentStory.educationalLevel = eduLevel;

    final collRef = FirebaseFirestore.instance.collection('UserStory');
    DocumentReference documentReference = collRef.doc();


    documentReference.set({
      'Title': _titleController.text,
      'Category': _categoryController.text,
      'Language': _languageController.text,
      'EducationLevel': eduLevel,
    }).whenComplete(() => { //The action function is called when this future completes, whether it does so with a value or with an error.
    Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => StoryDetails.userstory(documentReference.id,currentStory))),
    });
        
  }
}

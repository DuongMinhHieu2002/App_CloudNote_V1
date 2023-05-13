import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloudnote/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardColor.length);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  String date = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.cardColor[color_id],
        appBar: AppBar(
          backgroundColor: AppStyle.cardColor[color_id],
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Add new note",style: TextStyle(
            color: Colors.black,
          ),),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title'
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8.0,),
            Text(date,style: AppStyle.dateTitle,),
            SizedBox(height: 28,),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title'
              ),
              style: AppStyle.mainContent,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          Navigator.pop(context);
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title":_titleController.text,
            "creation_date":date,
            "note_content":_mainController.text,
            "color_id":color_id,
          }).then((value){
            print(value.id);

          }).catchError((error) => print("Failed to add new note to $error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

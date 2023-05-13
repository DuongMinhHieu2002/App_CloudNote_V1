import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloudnote/Notes.dart';

import '../style/app_style.dart';

class NoteRenderScreen extends StatefulWidget {
   NoteRenderScreen(this.notes,{Key? key}) : super(key: key);
   final Notes notes;


  @override
  State<NoteRenderScreen> createState() => _NoteRenderScreenState();
}

class _NoteRenderScreenState extends State<NoteRenderScreen> {

  @override
  Widget build(BuildContext context) {
    int Color_id = int.parse(widget.notes.colorId!);

    return Scaffold(
      backgroundColor:  AppStyle.cardColor[Color_id],
      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardColor[Color_id],
        elevation: 0.0,
      ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.notes.noteTitle,
                style: AppStyle.mainTitle,
              ),
              SizedBox(height: 4,),
              Text(
                widget.notes.creationDate,
                style: AppStyle.dateTitle,
              ),
              SizedBox(height: 10,),
              Text(
                widget.notes.nodeContent,
                style: AppStyle.mainContent,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
    );
  }
}

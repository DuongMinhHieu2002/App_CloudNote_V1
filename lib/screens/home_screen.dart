import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloudnote/screens/note_editer.dart';
import 'package:cloudnote/screens/note_render.dart';
import 'package:cloudnote/style/app_style.dart';
import 'package:cloudnote/widgets/note_cart.dart';

import '../Notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Notes> NotesItem = [];


  @override
  void initState() {
    fetchRecords();
    FirebaseFirestore.instance.collection("Notes").snapshots().listen((event) {
      mapRecords(event);
    });
    super.initState();
  }

  fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection("Notes").get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs.map((item) => Notes(
        id: item.id,
        nodeContent: item['note_content'],
        creationDate: item['creation_date'],
        noteTitle: item['note_title'],
        colorId: item['color_id'].toString())).toList();
    setState(() {
      NotesItem = _list;
      print(NotesItem.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Cloud Note"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Note",
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Notes")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: NotesItem.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NoteRenderScreen(NotesItem[index])));
                              },
                              child: Stack(
                                children: [Container(
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: AppStyle.cardColor[int.parse(NotesItem[index].colorId!)],
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        NotesItem[index].noteTitle,
                                        style: AppStyle.mainTitle,
                                      ),
                                      SizedBox(height: 4,),
                                      Text(
                                        NotesItem[index].creationDate,
                                        style: AppStyle.dateTitle,
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        NotesItem[index].nodeContent,
                                        style: AppStyle.mainContent,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                                  Positioned(
                                    top:100,
                                      right:8,
                                      child: IconButton(onPressed: () { 
                                        deleteItem(NotesItem[index].id);
                                      },icon: Icon(Icons.close),))
                                ]
                              ),
                            );
                          });
                    }
                  else
                      return Center(
                        child: Text(
                          "There's no Notes",
                          style: GoogleFonts.nunito(color: Colors.white),
                        ),
                      );

                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

deleteItem(String id){
  FirebaseFirestore.instance.collection("Notes").doc(id).delete();
}


import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  String id;
  String nodeContent;
  String creationDate;
  String noteTitle;
  String? colorId;

  Notes({
    required this.id,
    required this.nodeContent,
    required this.creationDate,
    required this.noteTitle,
    this.colorId,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    id: json["id"],
    nodeContent: json["node_content"],
    creationDate: json["creation_date"],
    noteTitle: json["note_title"],
    colorId: json["color_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "node_content": nodeContent,
    "creation_date": creationDate,
    "note_title": noteTitle,
    "color_id": colorId,
  };
}
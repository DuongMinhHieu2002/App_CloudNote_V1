import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloudnote/style/app_style.dart';


Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardColor[doc['color_id']],
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: AppStyle.mainTitle,
          ),
          SizedBox(height: 4,),
          Text(
            doc["creation_date"],
            style: AppStyle.dateTitle,
          ),
          SizedBox(height: 10,),
          Text(
            doc["node_content"],
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
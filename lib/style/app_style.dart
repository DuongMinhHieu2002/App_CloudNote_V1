import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static Color bgColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);


  static List<Color> cardColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
    Colors.amberAccent.shade100,
  ];


  static TextStyle mainTitle = GoogleFonts.roboto(
    fontWeight:FontWeight.bold,
    fontSize: 18,
  );
  static TextStyle mainContent = GoogleFonts.nunito(
    fontWeight:FontWeight.normal,
    fontSize: 16,
  );
  static TextStyle dateTitle = GoogleFonts.nunito(
    fontWeight:FontWeight.w500,
    fontSize: 13,
  );
}
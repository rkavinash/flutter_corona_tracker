import 'package:corona_tracker/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent[700],
        textTheme: TextTheme(
          headline1: GoogleFonts.anonymousPro(
              fontSize: 112, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.anonymousPro(
              fontSize: 70, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3: GoogleFonts.anonymousPro(
              fontSize: 56, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.anonymousPro(
              fontSize: 40, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5: GoogleFonts.anonymousPro(
              fontSize: 28, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.anonymousPro(
              fontSize: 23, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.anonymousPro(
              fontSize: 19, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.anonymousPro(
              fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.anonymousPro(
              fontSize: 19, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.anonymousPro(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.anonymousPro(
              fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.anonymousPro(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.anonymousPro(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
      home: HomePage(),
    );
  }
}

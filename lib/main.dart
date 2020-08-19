import 'package:corona_tracker/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      loadingText: Text(
        'We are together in the fight'.toUpperCase(),
        style: GoogleFonts.baiJamjuree(
          textStyle: Theme.of(context).textTheme.headline6,
          color: Colors.white,
        ),
      ),
      seconds: 3,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text(
        'Covid-19 Tracker'.toUpperCase(),
        style: GoogleFonts.baiJamjuree(
          textStyle: Theme.of(context).textTheme.headline4,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent[700],
      photoSize: 150.0,
      onClick: () => null,
      loaderColor: Colors.white,
    );
  }
}

class AfterSplash extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent[700],
        textTheme: TextTheme(
          headline1: GoogleFonts.baiJamjuree(
              fontSize: 102, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.baiJamjuree(
              fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3: GoogleFonts.baiJamjuree(
              fontSize: 51, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.baiJamjuree(
              fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5: GoogleFonts.baiJamjuree(
              fontSize: 25, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.baiJamjuree(
              fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.baiJamjuree(
              fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.baiJamjuree(
              fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.baiJamjuree(
              fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.baiJamjuree(
              fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.baiJamjuree(
              fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption: GoogleFonts.baiJamjuree(
              fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.baiJamjuree(
              fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
      home: HomePage(),
    );
  }
}

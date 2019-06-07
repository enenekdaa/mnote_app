import 'package:flutter/material.dart';
import 'package:mnote_app/page/appsetting_screen.dart';
import 'package:mnote_app/page/home_screen.dart';
import 'package:mnote_app/page/note_book_edit_screen.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/page/note_edit_screen.dart';
import 'package:mnote_app/page/note_view_screen.dart';
import 'package:mnote_app/page/profile_screen.dart';
import 'package:mnote_app/page/sign_in_screen.dart';
import 'package:mnote_app/page/sign_up_screen.dart';
import 'package:mnote_app/page/splash_screen.dart';
import 'package:mnote_app/page/premium_screen.dart';
import 'package:mnote_app/page/navigation_screen.dart';
import 'package:mnote_app/page/today_note_edit_screen.dart';
import 'package:mnote_app/page/today_note_list_screen.dart';
import 'package:mnote_app/page/today_note_subjects_screen.dart';
import 'package:mnote_app/page/today_note_main_screen.dart';
import 'package:mnote_app/page/today_note_view_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
//  "/star": (BuildContext context) => StarScreen(),
//  "/intro": (BuildContext context) => IntroScreen(),
  "/splash": (BuildContext context) => SplashScreen(),
  "/sign_in": (BuildContext context) => SignInScreen(),
  "/sign_up": (BuildContext context) => SignUnScreen(),
  "/note_book_view": (BuildContext context) => NoteBookViewScreen(),
  "/note_book_eidt": (BuildContext context) => NoteBookEditScreen(),
  "/note_view": (BuildContext context) => NoteViewScreen(),
  "/note_eidt": (BuildContext context) => NoteEditScreen(),
  "/today_note_main": (BuildContext context) => TodayNoteMainScreen(),
  "/today_note_edit": (BuildContext context) => TodayNoteEditScreen(),
  "/today_note_subjects": (BuildContext context) => TodayNoteSubjectsScreen(),
  "/today_note_list": (BuildContext context) => TodayNoteListScreen(),
  "/today_note_view": (BuildContext context) => TodayNoteViewScreen(),
  "/premium": (BuildContext context) => PremiumScreen(),
  "/app_setting": (BuildContext context) => AppSettingScreen(),
  "/profile": (BuildContext context) => ProfileScreen(),
  "/navigation": (BuildContext context) => NavigationScreen(),
};

void main() {
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//    systemNavigationBarColor: Colors.black,
//    statusBarColor: Colors.black,
//  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.yellowAccent,
          fontFamily: 'MNote'),
      home: SplashScreen(),
      routes: routes,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}

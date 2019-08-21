import 'package:flutter/material.dart';
import 'package:mnote_app/page/appsetting_screen.dart';
import 'package:mnote_app/page/daily_list_screen.dart';
import 'package:mnote_app/page/home_screen.dart';
import 'package:mnote_app/page/lock_screen.dart';
import 'package:mnote_app/page/lock_setting_screen.dart';
import 'package:mnote_app/page/note_book_edit_screen.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/page/note_edit_screen.dart';
import 'package:mnote_app/page/note_view_screen.dart';
import 'package:mnote_app/page/open_list_screen.dart';
import 'package:mnote_app/page/open_note_book_intro.dart';
import 'package:mnote_app/page/open_note_book_list_screen.dart';
import 'package:mnote_app/page/profile_screen.dart';
import 'package:mnote_app/page/sign_in_screen.dart';
import 'package:mnote_app/page/sign_up_screen.dart';
import 'package:mnote_app/page/splash_screen.dart';
import 'package:mnote_app/page/premium_screen.dart';
import 'package:mnote_app/page/navigation_screen.dart';
import 'package:mnote_app/page/daily_edit_screen.dart';
import 'package:mnote_app/page/daily_view_list_screen.dart';
import 'package:mnote_app/page/daily_my_screen.dart';
import 'package:mnote_app/page/daily_main_screen.dart';
import 'package:mnote_app/page/daily_view_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/splash": (BuildContext context) => SplashScreen(),
  "/lock": (BuildContext context) => LockScreen(),
  "/lockSetting": (BuildContext context) => LockSettingScreen(),
  "/sign_in": (BuildContext context) => SignInScreen(),
  "/sign_up": (BuildContext context) => SignUnScreen(),
  "/note_book_view": (BuildContext context) => NoteBookViewScreen(),
  "/note_book_eidt": (BuildContext context) => NoteBookEditScreen(),
  "/note_view": (BuildContext context) => NoteViewScreen(),
  "/note_eidt": (BuildContext context) => NoteEditScreen(),
  "/daily_main": (BuildContext context) => DailyMainScreen(),
  "/daily_edit": (BuildContext context) => DailyEditScreen(),
  "/daily_my": (BuildContext context) => DailyMyScreen(),
  "/daily_list": (BuildContext context) => DailyListScreen(),
  "/daily_view_list": (BuildContext context) => DailyViewListScreen(),
  "/daily_view": (BuildContext context) => DailyViewScreen(),
  "/open_list": (BuildContext context) => OpenListScreen(),
  "/open_note_book_list": (BuildContext context) => OpenNoteBookListScreen(),
  "/open_note_book_intro": (BuildContext context) => OpenNoteBookIntroScreen(),
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
          accentColor: Colors.black12,
          fontFamily: 'MNote'),
      home: SplashScreen(),
      routes: routes,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}

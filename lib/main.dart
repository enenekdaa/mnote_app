import 'package:flutter/material.dart';
import 'package:mnote_app/page/home_screen.dart';
import 'package:mnote_app/page/sign_in_screen.dart';
import 'package:mnote_app/page/sign_up_screen.dart';
import 'package:mnote_app/page/splash_screen.dart';





var routes = <String , WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
//  "/star": (BuildContext context) => StarScreen(),
//  "/intro": (BuildContext context) => IntroScreen(),
  "/splash": (BuildContext context) => SplashScreen(),
  "/sign_in": (BuildContext context) => SignInScreen(),
  "/sign_up": (BuildContext context) => SignUnScreen(),
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
          primaryColor: Colors.blue, accentColor: Colors.yellowAccent),
      home: SplashScreen(),
      routes: routes,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}


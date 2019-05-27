import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zefyr/zefyr.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.popAndPushNamed(context, '/sign_in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
//            child: Image.asset(
//              'images/icons/00_main_bg.png',
//            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  //    Image.asset('images/icons/00_main_logo.png', scale: 1.8),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
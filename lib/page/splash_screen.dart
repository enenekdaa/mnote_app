import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/sign_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences _prefs;

  void _login(String email, String pw) async {
    SignModel signModel = await getSignIn(email, pw);

    if (signModel.result == 'true') {
      _prefs.setString('access_token', signModel.accessToken);
      _prefs.setString('refresh_token', signModel.refreshToken);
      Mnote.accessToken = signModel.accessToken;
      Mnote.refreshToken = signModel.refreshToken;
      Mnote.myEmail = email;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _prefs.setString('auto_login', 'false');
      Navigator.pushReplacementNamed(context, '/sign_in');
    }
  }


  void _initSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      if (_prefs.getKeys().contains('auto_login')) {
        _prefs.get('auto_login') == 'true'
            ? _login(_prefs.get('auto_email'), _prefs.get('auto_pw'))
            : Navigator.pushReplacementNamed(context, '/sign_in');
      }else{
        Navigator.pushReplacementNamed(context, '/sign_in');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      _initSharedPreferences();
    });
  }

  @override
  void didUpdateWidget(SplashScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // 디바이스 너비 저장
    Mnote.deviceWidth = MediaQuery.of(context).size.width;
    print(' Mnote.deviceWidth::${Mnote.deviceWidth}');
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
                      Image.asset('images/icons/00_main_logo.png', scale: 1.8),
                      //Text('무제노트')
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

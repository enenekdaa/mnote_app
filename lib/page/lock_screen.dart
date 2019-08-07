import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/sign_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  SharedPreferences _prefs;

  String pass1 = ' 1';  //' ● '
  String pass2 = ' ';
  String pass3 = ' ';
  String pass4 = '';

  List<String> pass = ['●',' ',' ','',];

  List<Padding> btnList = [];

  void _initSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();

    for(var i=9 ; i > 0; i--){
      btnList.add(
          Padding(
            padding: EdgeInsets.all(0),
            child: Image.asset('images/icons/05_keypad_$i.png', scale: 1.8,),
          )
      );
    }

    btnList.add(
        Padding(
          padding: EdgeInsets.all(0),
          child: Image.asset('images/icons/05_keypad_0.png', scale: 1.8,),
        )
    );

    btnList.add(
        Padding(
          padding: EdgeInsets.all(0),
          child: Image.asset('images/icons/05_keypad_erase.png', scale: 1.8,),
        )
    );

  }

  @override
  void didUpdateWidget(LockScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: maxHeight / 5,),
              Text('비밀번호', style: Mnote.textFiledLabel,),
              SizedBox(height: maxHeight / 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(pass[0], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(pass[1], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(pass[2], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(pass[3], style: Mnote.textBlack_13_5,),
                  ),
                ],
              ),
              SizedBox(height: maxHeight / 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: (){
                      print(pass.indexOf(''));
                    },
                    child: btnList[0],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[1],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[2],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[3],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[4],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[5],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[6],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[7],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[8],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    opacity: 0.0,
                    child: MaterialButton(
                    onPressed: ()=>{},
                      child: btnList[9],
                    ),
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[9],
                  ),
                  MaterialButton(
                    onPressed: ()=>{},
                    child: btnList[10],
                  ),
                ],
              ),
            ],
          ),
          MaterialButton(
            onPressed: () => {
              Navigator.popAndPushNamed(context, '/home')
            },
            color: Mnote.orange,
            minWidth: MediaQuery.of(context).size.width,
            height: 60,
            child: Text('설정하기', style: Mnote.screenBottomBtnWText,),
          )
        ],
      )
    );
  }
}

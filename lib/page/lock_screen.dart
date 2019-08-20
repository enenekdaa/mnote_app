import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/sign_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  SharedPreferences _prefs;

  List<String> showPass = ['','','','',]; // ●
  List<String> privatePass = ['','','','',]; // ●
  List<Padding> btnList = [];

  void _initSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  void _changeNumber(String number){
    if (showPass.indexOf('') >= 0) {
      setState(() {
        showPass[showPass.indexOf('')] = '●';
        privatePass[privatePass.indexOf('')] = number;
      });
    }

    if (showPass.indexOf('') == -1){
      print(privatePass.join(''));
      // if(privatePass.join('') == Mnote.secretNumber){
      if(privatePass.join('') == '1234'){
        MyNavigator.goToHome(context);
      }else{
        Fluttertoast.showToast(msg: '비밀번호가 맞지 않습니다.');
      }
    }
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
                    child: Text(showPass[0], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(showPass[1], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(showPass[2], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(showPass[3], style: Mnote.textBlack_13_5,),
                  ),
                ],
              ),
              SizedBox(height: maxHeight / 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  MaterialButton(
                    onPressed: (){
                      _changeNumber('7');
                    },
                    child: btnList[2],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('8');
                    },
                    child: btnList[1],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('9');
                    },
                    child: btnList[0],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('4');
                    },
                    child: btnList[5],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('5');
                    },
                    child: btnList[4],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('6');
                    },
                    child: btnList[3],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('1');
                    },
                    child: btnList[8],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('2');
                    },
                    child: btnList[7],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('3');
                    },
                    child: btnList[6],
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
                    onPressed: (){
                      _changeNumber('0');
                    },
                    child: btnList[9],
                  ),
                  MaterialButton(
                    onPressed: (){
                      if (showPass.indexOf('') == 0) {
                        return;
                      }

                      if (showPass.indexOf('') > 0) {
                        setState(() {
                          showPass[showPass.indexOf('') - 1] = '';
                          privatePass[privatePass.indexOf('') - 1] = '';
                        });
                        return;
                      }

                      if (showPass.indexOf('') == -1) {
                        setState(() {
                          showPass[3] = '';
                          privatePass[3] = '';
                        });
                        return;
                      }

                    },
                    child: btnList[10],
                  ),
                ],
              ),
            ],
          ),
          Opacity(
            opacity: 0.0,
            child:
            MaterialButton(
              onPressed: () => {
                Navigator.popAndPushNamed(context, '/home')
              },
              color: Mnote.orange,
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: Text('설정하기', style: Mnote.screenBottomBtnWText,),
            )
          ),
        ],
      )
    );
  }
}

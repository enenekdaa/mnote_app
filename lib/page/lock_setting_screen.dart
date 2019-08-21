import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/sign_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockSettingScreen extends StatefulWidget {
  @override
  _LockSettingScreenState createState() => _LockSettingScreenState();
}

class _LockSettingScreenState extends State<LockSettingScreen> {
  SharedPreferences _prefs;

  int _passCheckCnt = 0;
  List<String> _passCheckString = ['비밀번호를 입력해 주세요.', '비밀번호를 한 번더 입력해 주세요.'];
  List<String> _showPass = ['','','','',];      // ●
  List<String> _privatePass = ['','','','',];   // 1234
  List<String> _privatePass_2 = ['','','','',]; // 1234
  List<Padding> _btnList = [];

  void _initSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  void _changeNumber(String number){

    if (_passCheckCnt == 0){
      if (_showPass.indexOf('') >= 0) {
        setState(() {
          _showPass[_showPass.indexOf('')] = '●';
          _privatePass[_privatePass.indexOf('')] = number;
        });
      }

      if (_showPass.indexOf('') == -1){
        setState(() {
          _passCheckCnt = 1;
          _showPass = ['','','','',];
        });
      }
    }
    else{
      if (_showPass.indexOf('') >= 0) {
        setState(() {
          _showPass[_showPass.indexOf('')] = '●';
          _privatePass_2[_privatePass_2.indexOf('')] = number;
        });
      }

      if (_showPass.indexOf('') == -1){
        print(_privatePass);
        print(_privatePass_2);
        if (_privatePass.join() == _privatePass_2.join()){
          Fluttertoast.showToast(msg: '비밀번호가 설정되었습니다.');
          _prefs.setString('secret_number', _privatePass.join(''));
          Navigator.pop(context, 'OK');
        }else{
          Fluttertoast.showToast(msg: '비밀번호가 맞지 않습니다. 다시 설정해주세요..');
          setState(() {
            _passCheckCnt = 0;
            _showPass = ['','','','',];
            _privatePass = ['','','','',];
            _privatePass_2 = ['','','','',];
          });
        }
      }
    }
  }

  void _backArrow(){
    if (_passCheckCnt == 0) {
      if (_showPass.indexOf('') == 0) {
        return;
      }

      if (_showPass.indexOf('') > 0) {
        setState(() {
          _showPass[_showPass.indexOf('') - 1] = '';
          _privatePass[_privatePass.indexOf('') - 1] = '';
        });
        return;
      }

      if (_showPass.indexOf('') == -1) {
        setState(() {
          _showPass[3] = '';
          _privatePass[3] = '';
        });
        return;
      }
    }
    else{
      if (_showPass.indexOf('') == 0) {
        return;
      }

      if (_showPass.indexOf('') > 0) {
        setState(() {
          _showPass[_showPass.indexOf('') - 1] = '';
          _privatePass_2[_privatePass_2.indexOf('') - 1] = '';
        });
        return;
      }

      if (_showPass.indexOf('') == -1) {
        setState(() {
          _showPass[3] = '';
          _privatePass_2[3] = '';
        });
        return;
      }
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();

    for(var i=9 ; i > 0; i--){
      _btnList.add(
          Padding(
            padding: EdgeInsets.all(0),
            child: Image.asset('images/icons/05_keypad_$i.png', scale: 1.8,),
          )
      );
    }

    _btnList.add(
        Padding(
          padding: EdgeInsets.all(0),
          child: Image.asset('images/icons/05_keypad_0.png', scale: 1.8,),
        )
    );

    _btnList.add(
        Padding(
          padding: EdgeInsets.all(0),
          child: Image.asset('images/icons/05_keypad_erase.png', scale: 1.8,),
        )
    );

  }

  @override
  void didUpdateWidget(LockSettingScreen oldWidget) {
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
              SizedBox(height: maxHeight / 20,),
              Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.keyboard_backspace, color: Colors.black,), onPressed: ()=>{
                    Navigator.pop(context)
                  }),
                ],
              ),
              SizedBox(height: maxHeight / 10,),
              Text(_passCheckString[_passCheckCnt], style: Mnote.textFiledLabel,),
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
                    child: Text(_showPass[0], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(_showPass[1], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(_showPass[2], style: Mnote.textBlack_13_5,),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: maxWidth / 20,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))
                    ),
                    child: Text(_showPass[3], style: Mnote.textBlack_13_5,),
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
                    child: _btnList[2],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('8');
                    },
                    child: _btnList[1],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('9');
                    },
                    child: _btnList[0],
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
                    child: _btnList[5],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('5');
                    },
                    child: _btnList[4],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('6');
                    },
                    child: _btnList[3],
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
                    child: _btnList[8],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('2');
                    },
                    child: _btnList[7],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('3');
                    },
                    child: _btnList[6],
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
                      child: _btnList[9],
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      _changeNumber('0');
                    },
                    child: _btnList[9],
                  ),
                  MaterialButton(
                    onPressed: (){
                      _backArrow();
                    },
                    child: _btnList[10],
                  ),
                ],
              ),
            ],
          ),
//          Opacity(
//            opacity: 1.0,
//            child:
//            MaterialButton(
//              onPressed: () => {
//                Navigator.popAndPushNamed(context, '/home')
//              },
//              color: Mnote.orange,
//              minWidth: MediaQuery.of(context).size.width,
//              height: 60,
//              child: Text('설정하기', style: Mnote.screenBottomBtnWText,),
//            )
//          ),
        ],
      )
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/user_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {

  List<String> _showPass = ['','','','',]; // ●
  List<String> _privatePass = ['','','','',]; // ●
  List<Padding> _btnList = [];

  void _changeNumber(String number){
    if (_showPass.indexOf('') >= 0) {
      setState(() {
        _showPass[_showPass.indexOf('')] = '●';
        _privatePass[_privatePass.indexOf('')] = number;
      });
    }

    if (_showPass.indexOf('') == -1){
      print(_privatePass.join(''));
      if(_privatePass.join('') == Mnote.secretNumber){
        //Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        setState(() {
          _showPass = ['','','','',];
          _privatePass = ['','','','',];
        });
        Fluttertoast.showToast(msg: '비밀번호가 맞지 않습니다.');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

                    },
                    child: _btnList[10],
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

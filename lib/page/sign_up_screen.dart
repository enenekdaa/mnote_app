import 'package:flutter/material.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/utils/mnote.dart';

class SignUnScreen extends StatefulWidget {
  @override
  _SignUnScreen createState() => new _SignUnScreen();
}

class _SignUnScreen extends State<SignUnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading:
            FlatButton(onPressed: () => Navigator.pop(context), child: null),
        title: Text(
          '회원가입',
          style: Mnote.appBarCenterTitle,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '입력완료',
              style: Mnote.appBarRightOkBtnText,
            ),
            padding: EdgeInsets.only(right: 30),
            onPressed: () => MyNavigator.goToSignIn(context),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                    alignment: Alignment(-1, 0),
                    child: Text(
                      '계정 입력',
                      style: Mnote.textFiledLabel,
                    ),
                  ),
                  Row(

                    children: <Widget>[
                      Expanded(
                        child: TextField(

                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'example@example.com',
                              hintStyle: Mnote.textFiledHint),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => {},
                        child: Image.asset('images/icons/01_btn_confirm.png', scale: 1.5,),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Mnote.black, width: 0.3)),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment(-1, 0),
                    child: Text('비밀번호 설정', style: Mnote.textFiledLabel),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: '비밀번호 입력', hintStyle: Mnote.textFiledHint),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: '비밀번호 재입력', hintStyle: Mnote.textFiledHint),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 40),
                    alignment: Alignment(-1, 0),
                    child: Text('필명 입력', style: Mnote.textFiledLabel),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '필명을 입력하세요.',
                              hintStyle: Mnote.textFiledHint),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {},
                        child: Image.asset('images/icons/01_btn_confirm.png', scale: 1.5,),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Mnote.black, width: 0.3)),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 40),
                    alignment: Alignment(-1, 0),
                    child: Text('소개', style: Mnote.textFiledLabel),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: '짧은 소개를 입력해주세요.'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

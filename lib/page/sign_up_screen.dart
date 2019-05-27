import 'package:flutter/material.dart';
import 'package:mnote_app/utils/m_navigator.dart';

class SignUnScreen extends StatefulWidget {
  @override
  _SignUnScreen createState() => new _SignUnScreen();
}

class _SignUnScreen extends State<SignUnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            FlatButton(onPressed: () => Navigator.pop(context), child: null),
        title: Text('회원가입'),
        actions: <Widget>[
          FlatButton(
            child: Text('입력완료'),
            onPressed: () => MyNavigator.goToSignIn(context),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              alignment: Alignment(-1, 0),
              child: Text('계정 입력'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'email...'),
                  ),
                ),
                FlatButton(
                  child: Text('중복확인'),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 40),
              alignment: Alignment(-1, 0),
              child: Text('비밀번호 재설정'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'password...'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'password 2...'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 40),
              alignment: Alignment(-1, 0),
              child: Text('필명 입력'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: '필명...'),
                  ),
                ),
                FlatButton(
                  child: Text('중복확인'),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5 , top: 40),
              alignment: Alignment(-1, 0),
              child: Text('소개'),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(hintText: '소개...'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

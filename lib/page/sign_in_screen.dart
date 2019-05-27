import 'package:flutter/material.dart';
import 'package:mnote_app/utils/m_navigator.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => new _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  bool _value1 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50),
              child: Text(
                "무제 노트",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.2, color: Colors.black38)),
                  hintText: 'email..',
                  hintStyle: TextStyle(color: Colors.black12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.2, color: Colors.black38)),
                  hintText: 'pass..',
                  hintStyle: TextStyle(color: Colors.black12),
                ),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: _value1,
                      onChanged: _value1Changed,
                      checkColor: Colors.black,
                      activeColor: Colors.purple,
                    ),
                    Text('자동 로그인')
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20 , bottom: 10),
              child: MaterialButton(
                onPressed: () => MyNavigator.goToHome(context),
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: Text(
                  '로그인',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Row(
              //mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () => {},
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('PW찾기')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => MyNavigator.goToSignUp(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('회원가입')
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

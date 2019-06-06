import 'package:flutter/material.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => new _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  bool _value1 = true;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                'images/icons/00_main_logo.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.2, color: Colors.black38)),
                        hintText: 'example@example.com',
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
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () => {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: _value1,
                            onChanged: _value1Changed,
                            checkColor: Colors.white,
                            activeColor: Colors.black,
                          ),
                          Text('자동 로그인')
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        MyNavigator.goToHome(context);
                      },
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
                            Text('PW찾기'),
                            Image.asset('images/icons/00_login_arrow.png', scale: 1.8,)
                          ],
                        ),
                      ),
                      Text('|', style: TextStyle(color: Colors.black12),),
                      FlatButton(
                        onPressed: () => MyNavigator.goToSignUp(context),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text('회원가입'),
                            Image.asset('images/icons/00_login_arrow.png', scale: 1.8,)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

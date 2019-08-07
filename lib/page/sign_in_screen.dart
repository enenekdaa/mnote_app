import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/sign_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => new _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  bool _isAutoLoginCheck = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SharedPreferences _prefs;

  void _value1Changed(bool value) => setState(() => _isAutoLoginCheck = value);

  void _login(String email, String pw) async {
    SignModel signModel = await getSignIn(email, pw);

    if (signModel.result == 'true') {
      _prefs.setString('access_token', signModel.accessToken);
      _prefs.setString('refresh_token', signModel.refreshToken);

      // 자동 로그인 설정
      if (_isAutoLoginCheck) {
        _prefs.setString('auto_login', 'true');
        _prefs.setString('auto_email', email);
        _prefs.setString('auto_pw', pw);
      }

      Mnote.accessToken = signModel.accessToken;
      Mnote.refreshToken = signModel.refreshToken;
      Mnote.myEmail = email;
      Navigator.popAndPushNamed(context, '/home');
    } else {
      Fluttertoast.showToast(msg: '계정 또는 비밀번호를 확인하세요.');
    }
  }

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
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: deviceHeight/30, right: deviceHeight/30),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: deviceHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/icons/00_main_logo.png',
                    scale: 1.8,
                  ),
                  SizedBox(
                    height: deviceHeight / 12,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.2, color: Colors.black38)),
                            hintText: 'example@example.com',
                            hintStyle: TextStyle(color: Colors.black12),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.2, color: Colors.black38)),
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
                                value: _isAutoLoginCheck,
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
                        margin: EdgeInsets.only(
                            top: 20, bottom: 10, left: 5, right: 5),
                        child: MaterialButton(
                          onPressed: () => _login(
                              emailController.text, passwordController.text),
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
                                Image.asset(
                                  'images/icons/00_login_arrow.png',
                                  scale: 1.8,
                                )
                              ],
                            ),
                          ),
                          Text(
                            '|',
                            style: TextStyle(color: Colors.black12),
                          ),
                          FlatButton(
                            onPressed: () => MyNavigator.goToSignUp(context),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Text('회원가입'),
                                Image.asset(
                                  'images/icons/00_login_arrow.png',
                                  scale: 1.8,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}

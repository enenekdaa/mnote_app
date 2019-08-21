import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/sign_service.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUnScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => new _SignUpScreen();
}

class _SignUpScreen extends State<SignUnScreen> {
  SharedPreferences _prefs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController writerNameController = TextEditingController();
  TextEditingController writerIntroController = TextEditingController();

  bool emailCheck = false;
  bool passwordCheck = false;
  bool writerNameCheck = false;

  void _signUp() async {
    if (!emailCheck || !writerNameCheck) {
      Fluttertoast.showToast(msg: '이메일 또는 필명 중복화인을 해주세요.');
      return;
    }

    String email = emailController.text.trim().replaceAll(' ', '');
    String password = passwordController.text.trim().replaceAll(' ', '');
    String password2 = password2Controller.text.trim().replaceAll(' ', '');
    String writerName = writerNameController.text;
    String writerIntro = writerIntroController.text;
    SignModel signModel =
    await getSignUp(email, password, password2, writerName, writerIntro);

    if (signModel.result == 'true') {
      Fluttertoast.showToast(msg: '회원가입이 완료되었습니다.');
      _prefs.setString('access_token', signModel.accessToken);
      _prefs.setString('refresh_token', signModel.refreshToken);
      Mnote.accessToken = signModel.accessToken;
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, '/home');
    } else if (signModel.result == 'duplicate') {
      Fluttertoast.showToast(msg: '중복된 이메일 또는 필명입니다.');
    } else if (signModel.result == 'password incorrect') {
      Fluttertoast.showToast(msg: '패스워드가 같은지 확인해주세요.');
    } else if (signModel.result == 'null') {
      Fluttertoast.showToast(msg: '빈칸이 입력되었습니다.');
    } else {
      Fluttertoast.showToast(msg: '회원가입중 오류가 발생되었습니다.');
    }
  }

  void _emailCheckClick() async {
    String email = emailController.text.trim().replaceAll(' ', '');

    if(email == ''){
      Fluttertoast.showToast(msg: '이메일을 입력해 주세요.');
      return;
    }

    if(Mnote.validateEmail(email) != null){
      Fluttertoast.showToast(msg: '이메일 형식을 확인해 주세요.');
      return;
    }

    emailCheck = await getEmailCheck(email);
    if (emailCheck) {
      Fluttertoast.showToast(msg: '사용 가능한 이메일 입니다.');
    } else {
      Fluttertoast.showToast(msg: '이미 사용중인 이메일 입니다.');
    }
  }

  void _writerNameCheckClick() async {
    String name = writerNameController.text.trim().replaceAll(' ', '');

    if(name == ''){
      Fluttertoast.showToast(msg: '필명을 입력해 주세요.');
      return;
    }

    writerNameCheck = await getWriterNameCheck(name);
    if (writerNameCheck) {
      Fluttertoast.showToast(msg: '사용 가능한 필명 입니다.');
    } else {
      Fluttertoast.showToast(msg: '이미 사용중인 필명 입니다.');
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
            onPressed: () => _signUp(),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: ConstrainedBox(
          constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
                          child: TextFormField(
                            onEditingComplete: () {
                              emailCheck = false;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: Mnote.validateEmail,
                            controller: emailController,
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
                          onTap: () => _emailCheckClick(),
                          child: Image.asset(
                            'images/icons/01_btn_confirm.png',
                            scale: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Mnote.mnoteBlack, width: 0.3)),
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
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: '비밀번호 입력', hintStyle: Mnote.textFiledHint),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: password2Controller,
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
                            onChanged: (text) {
                              writerNameCheck = false;
                            },
                            controller: writerNameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '필명을 입력하세요.',
                                hintStyle: Mnote.textFiledHint),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _writerNameCheckClick(),
                          child: Image.asset(
                            'images/icons/01_btn_confirm.png',
                            scale: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Mnote.mnoteBlack, width: 0.3)),
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
                        controller: writerIntroController,
                        decoration: InputDecoration(hintText: '짧은 소개를 입력해주세요.'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

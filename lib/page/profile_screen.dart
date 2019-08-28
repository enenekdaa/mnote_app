import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/writer_all.dart';
import 'package:mnote_app/service/user_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  WriterAll writerAll;
  bool writerNameCheck = false;
  TextEditingController writerNameController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  void _logout(){
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  void _initProfile() async {
    writerAll = await getMyProfile(context);
    // TODO:: API 확인되면 NULl 체크 하지 않아도 됨
    setState(() {
      introController.text = writerAll == null ? '안녕하세요 내 소개글입니다. ' : writerAll.writerIntro;
      writerNameController.text = writerAll == null ? '필명입니다. ' : writerAll.writerName;
    });
  }

  void _changeMyProfile() async {

    if (passwordController.text != passwordController2.text) {
      Fluttertoast.showToast(msg: '비밀번호 재확인이 맞는지 확인해주세요.');
      return;
    }

    if (writerNameCheck == false) {
      Fluttertoast.showToast(msg: '필명 중복 확인을 해주세요.');
      return;
    }

    String result = await changeMyProfile(
        context,
        Mnote.myEmail,
        writerNameController.text,
        introController.text,
        passwordController.text,
        passwordController2.text
    );

    if (result == 'true') {
      Fluttertoast.showToast(msg: '저장되었습니다.');
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: '저장에 실패하였습니다. 필명 중복확인 또는 비밀번호를 확인해주세요.');
    }
  }

  // 필명 체크
  void _writerNameCheckClick() async {
    String name = writerNameController.text.trim().replaceAll(' ', '');

    if(name == ''){
      Fluttertoast.showToast(msg: '필명을 입력해 주세요.');
      return;
    }

    writerNameCheck = await getWriterNameCheck(context, name);
    if (writerNameCheck) {
      Fluttertoast.showToast(msg: '사용 가능한 필명 입니다.');
    } else {
      Fluttertoast.showToast(msg: '이미 사용중인 필명 입니다.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initProfile();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.only(left: 30),
              child: Image.asset('images/icons/00_top_back.png')),
          title: Text(
            '프로필 설정',
            style: Mnote.appBarCenterTitle,
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: <Widget>[
            FlatButton(
              child: Text(
                '저장',
                style: Mnote.appBarRightOkBtnText,
              ),
              onPressed: () => _changeMyProfile(),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body:
        SingleChildScrollView(
          padding: EdgeInsets.only(left: deviceHeight/30, right: deviceHeight/30),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: deviceHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            Mnote.myEmail,
                            style: Mnote.textFiledLabel,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.black, width: 0.5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: writerNameController,
                                  decoration: InputDecoration(
                                      hintText: '나의 필명',
                                      hintStyle: Mnote.textFiledHint,
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () => _writerNameCheckClick(),
                                color: Colors.black,
                                shape: StadiumBorder(),
                                elevation: 0,
                                child: Text(
                                  '중복확인',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '나의 소개',
                            style: Mnote.textFiledLabel,
                          ),
                        ),
                        Container(
                            child: TextField(
                              controller: introController,
                              minLines: 1,
                              maxLines: 2,
                              maxLength: 50,
                              decoration: InputDecoration(hintText: '내 소개를 입력해주세요.', hintStyle: TextStyle(color: Colors.grey)),
                            )
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '비밀번호 재설정',
                            style: Mnote.textFiledLabel,
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(hintText: '비밀번호 입력'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController2,
                          decoration: InputDecoration(hintText: '비밀번호 재입력'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () => {MyNavigator.goToPremium(context)},
                        height: 60,
                        child: Text('프리미엄 구매', style: Mnote.screenBottomBtnWText),
                        color: Mnote.orange,
                        textColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width / 2,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _logout();
                        },
                        height: 60,
                        child: Text('로그아웃', style: Mnote.screenBottomBtnWText),
                        color: Colors.black,
                        textColor: Colors.white,
                        minWidth: MediaQuery.of(context).size.width / 2,
                      ),
                    ],
                  ),
                ],
              )),
        ));

  }
}

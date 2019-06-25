import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'adsadsasd@asdasda.ccc',
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
                            decoration: InputDecoration(
                                hintText: '나의 필명',
                                hintStyle: Mnote.textFiledHint,
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => {},
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
                    child: Text('내 소개 내용 여기 더블 터치하면 수정가능  최대 글자 \n' +
                        '수 제한 50자 2줄까지 들어갈 수 있습니다. '),
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
                    decoration: InputDecoration(hintText: '비밀번호 입력...'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: '비밀번호 재입력...'),
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    MyNavigator.goToSignIn(context);
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
        ));
  }
}

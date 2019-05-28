import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            FlatButton(onPressed: () => Navigator.pop(context), child: null),
        title: Text('프로필 설정'),
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.all(10),
                    child: Text('adsadsasd@asdasda.ccc'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '나의 필명 ...',
                              hintStyle: TextStyle(color: Colors.black12),
                            ),
                          ),
                        ),
                        RaisedButton(child: Text('중복확인'), onPressed: () => {}),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.all(10),
                    child: Text('나의 소개'),
                  ),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.all(10),
                    child: Text('주저리 주저리.....\nasdasdasdassd\nadasdasdad\n'),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 40),
                    alignment: Alignment(-1, 0),
                    child: Text('비밀번호 재설정'),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: '비밀번호 입력...'),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: '비밀번호 재입력...'),
                  ),


                ],
              ),
            ),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(child: Text('프리미엄 구매'), color: Colors.black54,textColor: Colors.white, onPressed: ()=> {}, ),
                  FlatButton(child: Text('로그아웃'),color: Colors.black54 , textColor: Colors.white, onPressed: ()=> {}, ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mnote_app/utils/mnote.dart';

class AppSettingScreen extends StatefulWidget {
  @override
  _AppSettingScreenState createState() => new _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  bool _appsetting = false;
  bool _secret = false;
  bool _todayalarm = false;
  bool _firstwrite = false;

  String tv = 'http://www.abc.com';

  void _appsettingChanged(bool value) => setState(() => _appsetting = value);

  void _todayalarmChanged(bool value) => setState(() => _todayalarm = value);

  void _secretChanged(bool value) => setState(() => _secret = value);

  void _firstwriteChanged(bool value) => setState(() => _firstwrite = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.only(left: 20),
            child: Image.asset(
              'images/icons/00_top_back.png',
            )),
        title: Text(
          '앱 설정',
          style: Mnote.appBarCenterTitle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '무제노트',
                      ),
                    ),
                  ),
                  Switch(
                    value: _appsetting,
                    onChanged: _appsettingChanged,
                    activeColor: Colors.purple,
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  alignment: Alignment(-1, 0),
                  padding: EdgeInsets.all(20),
                  child: Text('글꼴 선택'),
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PC 버전',
                  ),
                  Text(
                    '프리미엄 구매자만 이용 가능합니다',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(tv),
                        RaisedButton(
                          child: Text('주소복사'),
                          onPressed: () =>
                              Clipboard.setData(new ClipboardData(text: tv)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '잠금 설정',
                      ),
                    ),
                  ),
                  Switch(
                    value: _secret,
                    onChanged: _secretChanged,
                    activeColor: Colors.purple,
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '하루 글감 알림',
                      ),
                    ),
                  ),
                  Switch(
                    value: _todayalarm,
                    onChanged: _todayalarmChanged,
                    activeColor: Colors.purple,
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '첫 화면 글쓰기',
                      ),
                    ),
                  ),
                  Switch(
                    value: _firstwrite,
                    onChanged: _firstwriteChanged,
                    activeColor: Colors.purple,
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

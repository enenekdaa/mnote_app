import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSettingScreen extends StatefulWidget {
  @override
  _AppSettingScreenState createState() => new _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  bool _appsetting = false;
  bool _secret = false;
  bool _todayalarm = false;
  bool _firstwrite = false;

  String tv = 'http://////fdfsdf//';
  void _appsettingChanged(bool value) => setState(() => _appsetting = value);
  void _todayalarmChanged(bool value) => setState(() => _todayalarm = value);
  void _secretChanged(bool value) => setState(() => _secret = value);
  void _firstwriteChanged(bool value) => setState(() => _firstwrite = value);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            FlatButton(onPressed: () => Navigator.pop(context), child: null),
        title: Text('앱 설정'),
      ),
      body: Container(
        alignment: Alignment(-1, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 1.5,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '앱 설정',
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
              height: 1.5,
              color: Colors.grey,
            ),
            Container(
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  alignment: Alignment(-1, 0),
                  padding: EdgeInsets.all(10),
                  child: Text('글꼴 선택'),
                ),
              ),
            ),
            Container(
              height: 1.5,
              color: Colors.grey,
            ),
            Container(
              child: Column(
                children: <Widget>[

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('PC 버전' , style: TextStyle(fontSize: 20),),
                          Text('(프리미엄 구매자만 가능합니다)' , style: TextStyle(fontSize: 10),),
                        ],
                      ),
                    ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Text(tv),
                        RaisedButton(child: Text('주소복사'),
                          onPressed: () => Clipboard.setData(new ClipboardData(text: tv)
                        ),),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.5,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(10),
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
              height: 1.5,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(10),
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
              height: 1.5,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1, 0),
                      padding: EdgeInsets.all(10),
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
            Container(
              height: 1.5,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

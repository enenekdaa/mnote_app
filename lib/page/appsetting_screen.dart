import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingScreen extends StatefulWidget {
  @override
  _AppSettingScreenState createState() => new _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  SharedPreferences _prefs;
  
  bool _appsetting = false;
  bool _secret = false;
  bool _todayAlarm = false;
  bool _firstWrite = false;

  String tv = 'http://www.abc.com';

  void _appsettingChanged(bool value) => setState(() => _appsetting = value);

  void _secretChanged(bool value) => setState(() => _secret = value);

  // 하루 글감 알림
  void _todayAlarmChanged(bool value) {
    //TODO:: 서버에 토큰값 보내야하나?
    setState(() => _todayAlarm = !value);
    _prefs.setString('today_alarm_mode', _todayAlarm == true ? 'ON' : 'OFF');
    Mnote.todayAlarmMode = _todayAlarm == true ? 'ON' : 'OFF';
  }

  // 첫화면 글쓰기
  void _firstWriteChanged(bool value) {
    setState(() => _firstWrite = !value);
    _prefs.setString('home_edit_mode', _firstWrite == true ? 'ON' : 'OFF');
    Mnote.homeEditMode = _firstWrite == true ? 'ON' : 'OFF';
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
    _firstWrite = Mnote.homeEditMode == 'ON';
    _todayAlarm = Mnote.todayAlarmMode == 'ON';
  }

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
              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('야간모드', style: TextStyle(fontSize: 18),),
                  GestureDetector(
                    child: Image.asset('images/icons/00_toggle_off.png', scale: 1.8,),
                  )
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  child: Text('글꼴 선택', style: TextStyle(fontSize: 18),),
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'PC 버전', style: TextStyle(fontSize: 18)
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '프리미엄 구매자만 이용 가능합니다',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(tv),
                      GestureDetector(
                        child: Image.asset('images/icons/05_btn_copy.png', scale: 1.8,),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('잠금 설정', style: TextStyle(fontSize: 18)),
                  GestureDetector(
                    child: Image.asset(
                      'images/icons/00_toggle_on.png', scale: 1.8,),
                  )
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('하루 글감 알림', style: TextStyle(fontSize: 18)),
                  GestureDetector(
                    onTap: () => _todayAlarmChanged(_todayAlarm),
                    child: Image.asset(
                      _todayAlarm ? 'images/icons/00_toggle_on.png' : 'images/icons/00_toggle_off.png', scale: 1.8,),
                  )
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('첫화면 글쓰기', style: TextStyle(fontSize: 18)),
                  GestureDetector(
                    onTap: () => _firstWriteChanged(_firstWrite),
                    child: Image.asset(
                      _firstWrite ? 'images/icons/00_toggle_on.png' :'images/icons/00_toggle_off.png', scale: 1.8,),
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

import 'package:flutter/material.dart';
import 'package:mnote_app/dialog/report_dialog.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => new _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  void _showReportDialog() {
    setState(() {
      showDialog(context: context, builder: (_) => ReportDialog());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: FlatButton(
              onPressed: () => {Navigator.pop(context)},
              child: Image.asset('images/icons/00_chapter_pre.png')),
          title: Text(
            '무제노트',
            style: Mnote.appBarCenterTitle,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => {Navigator.pop(context)},
              child: Image.asset(
                'images/icons/00_top_close.png',
                scale: 1.8,
              ),
            )
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () => MyNavigator.goToAppSetting(context),
                        child: Text('앱 설정')),
                    FlatButton(
                        onPressed: () => MyNavigator.goToPremium(context),
                        child: Text('프리미엄 구매')),
                    FlatButton(
                        onPressed: () => _showReportDialog(),
                        child: Text('하루 글감 제보하기')),
                    FlatButton(onPressed: () => {}, child: Text('책 만들기')),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                    onPressed: () => {MyNavigator.goToProfile(context)},
                    child: Text(
                      '내 프로필 설정',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}

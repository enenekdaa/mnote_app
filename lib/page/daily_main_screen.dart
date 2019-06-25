import 'package:flutter/material.dart';
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/page/daily_edit_screen.dart';
import 'package:mnote_app/service/daily_today_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/widget/monote_line.dart';

import 'note_edit_screen.dart';
import 'note_last_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class DailyMainScreen extends StatefulWidget {
  final String noteTitle;

  const DailyMainScreen({
    this.noteTitle
  });

  @override
  _DailyMainScreenState createState() => _DailyMainScreenState();
}

class _DailyMainScreenState extends State<DailyMainScreen> {
  DailyModel dailyModel;

  // 하루 글감 정보 조회
  void _initDailyToday() async {
    DailyModel newDailyModel = await getDailyToday();
    setState(() {
      dailyModel = newDailyModel;
    });
  }

  // 글쓰기 버튼 클릭
  void _editBtnClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyEditScreen(dailyModel: dailyModel)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyModel = DailyModel(
      dailyTitle: '',
      dailyDate: '',
      dailySentence: '',
      dailyWriter: '',
      dailyFrom: '',
    );
    _initDailyToday();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            padding: EdgeInsets.only(left: 30),
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_chapter_pre.png')),
        backgroundColor: Colors.black,
        title: Text(widget.noteTitle),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              '내글보기',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => MyNavigator.goToDailySubject(context),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body:
      Container(
        padding: EdgeInsets.all(30),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(dailyModel.dailyTitle, style: TextStyle(height: 1.5, fontSize: 22.5)),
                  SizedBox(height: 20,),
                  Text(dailyModel.dailyDate, style: Mnote.textHint_13_5,),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(dailyModel.dailySentence,
                    style: TextStyle(height: 1.8, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20,),
                  Text(dailyModel.dailyWriter, style: Mnote.textHint_13_5, textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                  Text(dailyModel.dailyFrom, style: Mnote.textHint_13_5,),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => _editBtnClick(),
                child: Image.asset('images/icons/08_btn_write.png', scale: 1.8,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

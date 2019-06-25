import 'package:flutter/material.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/service/daily_today_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'note_edit_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);


class DailyEditScreen extends StatefulWidget {
  final DailyModel dailyModel;
  DailyEditScreen({this.dailyModel});
  @override
  _DailyEditScreenState createState() => _DailyEditScreenState();
}

class _DailyEditScreenState extends State<DailyEditScreen> {

  bool visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  
  void _onContentDoubleTap(bool visibilityTime) {
    setState(() {
      visibilityEditFinishBtn = visibilityTime;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        title: Text(widget.dailyModel.dailyTitle),
        centerTitle: true,
        actions: <Widget>[
          visibilityEditFinishBtn
              ? Row()
              : FlatButton(
                  padding: EdgeInsets.only(right: 30),
                  child: Text('작성완료', style: Mnote.appBarRightOkBtnText),
                  onPressed: (){
                    Navigator.pop(context);
                    MyNavigator.goToDailySubject(context);
                  },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: NoteEditScreen(
        chapterModel: ChapterModel(
          chapterTitle: widget.dailyModel.dailyTitle,
          contents: '',
          contentsAlignCenter: '0',
          chapterStartDate: DateTime.now().toString()
        ),
        mode: 'daily',
        contentDoubleTabCallback: _onContentDoubleTap,
      )
    );
  }
}

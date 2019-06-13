import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/widget/monote_line.dart';

import 'note_edit_screen.dart';
import 'note_last_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class TodayNoteEditScreen extends StatefulWidget {
  TodayNoteEditScreen();
  @override
  _TodayNoteEditScreenState createState() => _TodayNoteEditScreenState();
}

class _TodayNoteEditScreenState extends State<TodayNoteEditScreen> {

  bool visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  
  void _onContentDoubleTap(bool visibilityTime) {
    setState(() {
      visibilityEditFinishBtn = visibilityTime;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();;
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
        title: Text('그리움'),
        centerTitle: true,
        actions: <Widget>[
          visibilityEditFinishBtn
              ? Row()
              : FlatButton(
                  padding: EdgeInsets.only(right: 30),
                  child: Text('작성완료', style: Mnote.appBarRightOkBtnText),
                  onPressed: (){
                    Navigator.pop(context);
                    MyNavigator.goToTodayNoteSubject(context);
                  },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: NoteEditScreen(
        contentDoubleTabCallback: _onContentDoubleTap,
      )
    );
  }
}

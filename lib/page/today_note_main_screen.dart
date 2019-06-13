import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/widget/monote_line.dart';

import 'note_edit_screen.dart';
import 'note_last_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class TodayNoteMainScreen extends StatefulWidget {
  final String noteTitle;

  const TodayNoteMainScreen({
    this.noteTitle
  });

  @override
  _TodayNoteMainScreenState createState() => _TodayNoteMainScreenState();
}

class _TodayNoteMainScreenState extends State<TodayNoteMainScreen> {
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
        title: Text(widget.noteTitle),
        centerTitle: true,
        actions: <Widget>[],
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
                  Text('그리움', style: TextStyle(height: 1.5, fontSize: 22.5)),
                  SizedBox(height: 20,),
                  Text('2019.05.23', style: Mnote.textHint_13_5,),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('그리움에 대한 한 문장 대략 2-3줄 출력. 그리움에 대한 한 문장 대략'
                      +'2-3줄 출력. 그리움에 대한 한 문장 대략 2-3줄 출력.',
                    style: TextStyle(height: 1.8, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30,),
                  Text('출처 : 어디 누구 책', style: Mnote.textHint_13_5, textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                  Text('<그리움> 중...', style: Mnote.textHint_13_5,),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => MyNavigator.goToTodayNoteEdit(context),
                child: Image.asset('images/icons/08_btn_write.png', scale: 1.8,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

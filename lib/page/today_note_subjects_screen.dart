import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class TodayNoteSubjectsScreen extends StatefulWidget {
  @override
  _TodayNoteSubjectsScreenState createState() => new _TodayNoteSubjectsScreenState();
}

class _TodayNoteSubjectsScreenState extends State<TodayNoteSubjectsScreen> {
  List<String> _noteList = [
    '그리움',
    '사과',
    '딸기',
    '선풍기',
    '비',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_chapter_pre.png')),
        backgroundColor: Colors.black,
        title: Text('무제 노트'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 25,
                    bottom: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => {MyNavigator.goToNoteBookEdit(context)},
                      child: Text(
                        '하루 글감',
                        style: Mnote.noteTitleFiledHint,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => {},
                          child: Text('하지원',style: TextStyle(decoration: TextDecoration.underline, fontSize: 16),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 0.2,
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.grey,
            ),
            Expanded(
                flex: 5,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _noteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _note(index, _noteList);
                    })),
          ],
        ),
      ),
    );
  }

  Widget _note(int index, List<String> noteList) {
    return GestureDetector(
        onTap: () => MyNavigator.goToTodayNoteList(context),
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('2019.06.'+(index+1).toString().padLeft(2, '0'), style: TextStyle(color: Mnote.gray153),),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Text(
                  noteList[index],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Mnote.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class NoteBookViewScreen extends StatefulWidget {
  @override
  _NoteBookViewScreenState createState() => new _NoteBookViewScreenState();
}

class _NoteBookViewScreenState extends State<NoteBookViewScreen> {
  List<String> _noteList = [
    '처음으로',
    '이건 그냥 하는 농담이지만',
    '실연당하는 게 끔찍할까, 시나리오 쓰는 게 더 끔찍할까끔찍할까끔찍할까?',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
    '노트 제목',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_chapter_pre.png')),
        backgroundColor: Colors.black,
        title: Text('무제노트'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              '완결하기',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints.expand(),
                margin: EdgeInsets.only(
                    left: 25,
                    top: MediaQuery.of(context).size.height / 20,
                    right: 25,
                    bottom: MediaQuery.of(context).size.height / 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => {MyNavigator.goToNoteBookEdit(context)},
                      child: Text(
                        '잘돼가? 무엇이든',
                        maxLines: 1,
                        style: Mnote.noteTitleFiledHint,
                      ),
                    ),
                    Text(
                      '이경미 첫번째 이야기',
                      style: Mnote.noteSubTitleFiledHint,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => {},
                          child: Image.asset(
                            'images/icons/00_toggle_02_on.png',
                            scale: 1.8,
                          ),
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
            FlatButton(
              onPressed: () => {},
              child: Text(
                '+ 글쓰기',
                style: TextStyle(fontSize: 15, color: Mnote.orange),
              ),
            ),
            Expanded(
                flex: 3,
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
        onTap: () => MyNavigator.goToNoteView(context),
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(index.toString().padLeft(2, '0'), style: TextStyle(color: Mnote.gray153),),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
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

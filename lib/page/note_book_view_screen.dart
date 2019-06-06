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
            child: Image.asset('images/icons/00_top_menu.png')),
        backgroundColor: Colors.black,
        title: Text('무제노트'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '완결하기',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
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
                margin: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      '잘돼가? 무엇이든',
                      maxLines: 2,
                      style: Mnote.noteTitleFiledHint,
                    ),
                    Text(
                      '이경미 첫번째 이야기',
                      style: Mnote.noteSubTitleFiledHint,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () => {},
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
              child: Text('+ 글쓰기', style: TextStyle(fontSize: 15, color: Mnote.orange),),
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
              Text(index.toString().padLeft(2, '0')),
              SizedBox(width: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(noteList[index], maxLines: 2, overflow: TextOverflow.ellipsis, ),
              ),
            ],
          ),
        ));
  }
}

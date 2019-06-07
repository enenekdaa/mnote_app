import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/widget/monote_line.dart';

import 'note_edit_screen.dart';
import 'note_last_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class NoteViewScreen extends StatefulWidget {
  ContentDoubleTabHandler contentDoubleTabCallback;

  NoteViewScreen({this.contentDoubleTabCallback});

  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {

  bool _visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  bool _editorMode = false;    // 에디터 모드
  
  int _currentPageIndex = 0;

  void _onContentDoubleTap(bool visibilityTime) {
    setState(() {
      _visibilityEditFinishBtn = visibilityTime;
    });
  }


  void _editorModeChange() {
    setState(() {
      _editorMode = !_editorMode;
    });
  }

  void _onPageChanged(int index){
    setState(() {
      _currentPageIndex = index;
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
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_top_menu.png')),
        backgroundColor: Colors.black,
        title: Text('무제노트'),
        centerTitle: true,
        actions: <Widget>[
          _currentPageIndex == 0 ?
          FlatButton(
            child: Text(
              _editorMode ? '완료하기' : '수정하기',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => _editorModeChange(),
          ): Row(),
          SizedBox(width: 20,)
        ],
      ),
      backgroundColor: Colors.white,
      body: PageView(
        onPageChanged: (index) => _onPageChanged(index),
        children: <Widget>[
          _editorMode ? NoteEditScreen(contentDoubleTabCallback: _onContentDoubleTap,) : Column(
            children: <Widget>[
              // 본문
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      //minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Column(
                      children: <Widget>[
                        // body
                        Container(
                          padding: EdgeInsets.all(38),
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(),
                              child: Column(
                                children: <Widget>[
                                  // 제목 입력 폼
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        // 제목
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '우리의 청춘이',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Mnote.noteTitleFiledHint,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // 날짜 영역
                                        Container(
                                          margin: EdgeInsets.only(bottom: 15),
                                          child: Text(
                                            '2019년 06월 01일 14:22',
                                            style: Mnote.noteSubTitleFiledHint,
                                          ),
                                        ),
                                        // 주황색 선
                                        OrangeLine(),
                                        Text(' 이상! 우리의 청춘이 가장 많이 품고 있는 이상! 이것이야말로 무한한 가치를 가진 것이다. 사람은 크고 작고 \n\n' +
                                            '그러므로 그들은 길지 아니한 목숨을 사는가 싶이 살았으며 그들의 그림자는 천고에 사라지지않는 것이다. \n' +
                                            '이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 청공에 반짝이는 뭇 벌과 같이 산야에 피어나는 군명과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니 인생에 가치를 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 청공에 반짝이는 뭇 벌과 같이 산야에 피어나는 군명과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니.  인생에 가치를 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도...\n\n' +
                                            '이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 청공에 반짝이는 뭇 벌과 같이 산야에 피어나는 군명과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니 인생에 가치를 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 청공에 반짝이는 뭇 벌과 같이 산야에 피어나는 군명과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니.  인생에 가치를 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도...\n\n' +
                                            '이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 청공에 반짝이는 뭇 벌과 같이 산야에 피어나는 군명과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니 인생에 가치를 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도 청공에 반짝이는 뭇 벌과 같이 산야에 피어나는 군명과 같이 이상은 실로 인간의 부패를 방지하는 소금이라 할지니.  인생에 가치를 이것은 현저하게 일월과 같은 예가 되려니와 그와 같지 못하다 할지라도...',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(height: 1.5, fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // footer
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 38, right: 38),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text('목록으로', style: TextStyle(color: Colors.white),),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset('images/icons/00_chapter_pre.png', scale: 1.8,),
                        SizedBox(width: 20,),
                        Image.asset('images/icons/00_chapter_next.png', scale: 1.8),
                      ],)
                  ],
                ),
              )
            ],
          ),
          NoteLastScreen()
        ],
      ),
        
    );
  }
}

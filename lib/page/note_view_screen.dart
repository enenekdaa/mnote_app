import 'package:flutter/material.dart';
import 'package:mnote_app/dialog/common_back_dialog.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/widget/monote_line.dart';

import 'note_edit_screen.dart';
import 'note_last_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class NoteViewScreen extends StatefulWidget {
  final String bookNo;
  final String chapterNo;
  final List<ChapterModel> chapterList;
  final bool editorMode;
  int idx;
  NoteViewScreen({this.bookNo, this.chapterNo, this.chapterList, this.idx, this.editorMode});

  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  ChapterModel chapterModel;
  bool _visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  bool _editorMode = false;    // true = 수정중인 상태 // false = 보기모드
  int _currentPageIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();

  void _onContentDoubleTap(bool visibilityTime) {
    setState(() {
      _visibilityEditFinishBtn = visibilityTime;
    });
  }

  void _editorModeChange() {
    // 에디터 모드가 수정상태 => 완료하기이면 수정된 내용을 저장한다.
    if (_editorMode){
      updateChapter(widget.bookNo, widget.chapterNo, titleController.text, contentsController.text, '0',);
    }

    setState(() {
      _editorMode = !_editorMode;
    });
  }

  void _onPageChanged(int index){
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _nextBtnClick(){
    if(widget.idx < widget.chapterList.length -1){
      setState(() {
        widget.idx = widget.idx + 1;
        chapterModel = widget.chapterList[widget.idx];
      });
    }
  }

  void _prevBtnClick(){
    if(widget.idx > 0){
      setState(() {
        widget.idx = widget.idx - 1;
        chapterModel = widget.chapterList[widget.idx];
      });
    }
  }

  // 정말로 뒤로 가시겠습니까? 다이얼로그
  void _showCommonBackDialog() {
    showDialog(
      context: context,
      builder: (_) => CommonBackDialog(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chapterModel = widget.chapterList[widget.idx];
    _editorMode = widget.editorMode;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        _showCommonBackDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () {
                _showCommonBackDialog();
              },
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
            _editorMode
                ? NoteEditScreen(chapterModel: chapterModel, contentDoubleTabCallback: _onContentDoubleTap, titleController: titleController, contentsController: contentsController,)
                : Column(
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
                                            chapterModel.chapterTitle,
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
                                              chapterModel.chapterStartDate,
                                              style: Mnote.noteSubTitleFiledHint,
                                            ),
                                          ),
                                          // 주황색 선
                                          OrangeLine(),
                                          Text(chapterModel.contents,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(height: 1.5, fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                          Opacity(
                            opacity: widget.idx > 0 ? 1.0 : 0.0,
                            child: GestureDetector(
                              onTap: _prevBtnClick,
                              child: Image.asset('images/icons/00_chapter_pre.png', scale: 1.8,),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Opacity(
                            opacity: widget.chapterList.length-1 > widget.idx ? 1.0 : 0.0,
                            child: GestureDetector(
                              onTap: _nextBtnClick,
                              child: Image.asset('images/icons/00_chapter_next.png', scale: 1.8),
                            ),
                          ),

                        ],)
                    ],
                  ),
                )
              ],
            ),
            widget.chapterList.length - 1 == widget.idx ? NoteLastScreen(bookNo: widget.bookNo,) : null
          ],
        ),

      ),
    );
  }
}

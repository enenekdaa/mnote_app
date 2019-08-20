import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/dialog/common_back_dialog.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/service/book_other_service.dart';
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
  final String bookEmail; // 빈값('') 일 경우 내글 보기
  int idx;
  NoteViewScreen({this.bookNo, this.chapterNo, this.chapterList, this.idx, this.editorMode, this.bookEmail = ''});

  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  ChapterModel chapterModel;
  bool _editorMode = false;    // true = 수정중인 상태 // false = 보기모드
  int _currentPageIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();
  FocusNode titleFocusNode = FocusNode(); // 제목 포커스 노드
  FocusNode contentsFocusNode = FocusNode(); // 내용// 포커스 노드
  NoteEditScreen noteEditScreen;

  void _editorModeChange(bool editorMode) async {
    // 에디터 모드가 수정상태 => 완료하기이면 수정된 내용을 저장한다.
    print(noteEditScreen.textAlignmentValue);
    if (_editorMode){
      if (titleController.text.trim().replaceAll(' ', '') == ''){
        Fluttertoast.showToast(msg: '제목을 입력해주세요. ');
        return;
      }
      
      await updateChapter(widget.bookNo, widget.chapterNo, titleController.text, contentsController.text, noteEditScreen.textAlignmentValue,).then((result){
        if (result != 'fail'){
          Fluttertoast.showToast(msg: '챕터 수정에 성공하였습니다.');
          _updateState(widget.bookNo, widget.chapterNo);
        }else{
          Fluttertoast.showToast(msg: '챕터 수정에 실패하였습니다.');
        }
      });
    }

    setState(() {
      _editorMode = !editorMode;
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
      _updateState(widget.bookNo, widget.chapterList[widget.idx].chapterNo);
    }
  }

  void _prevBtnClick(){
    if(widget.idx > 0){
      setState(() {
        widget.idx = widget.idx - 1;
        chapterModel = widget.chapterList[widget.idx];
      });
      _updateState(widget.bookNo, widget.chapterList[widget.idx].chapterNo);
    }
  }

  // 정말로 뒤로 가시겠습니까? 다이얼로그
  void _showCommonBackDialog() {
    if(_editorMode){
      showDialog(
        context: context,
        builder: (_) => CommonBackDialog(),
      ).then((result){
        if (result != null && result == 'update'){
          _editorMode = false;
          _updateState(widget.bookNo, widget.chapterNo);
        }
      });
    }else{
      Navigator.pop(context);
    }
  }

  void _contentFieldFocusListener() {
    print('_contentFieldFocusListener');
    print("Has focus: ${contentsFocusNode.hasFocus}");
    setState(() {
      contentsFocusNode.hasFocus;
    });
  }

  void _titleFieldFocusListener(){
    print('_titleFieldFocusListener');
    print("Has focus: ${titleFocusNode.hasFocus}");
    setState(() {
      titleFocusNode.hasFocus;
    });
  }

  void _updateState(bookNo, chapterNo) async {
    ChapterModel updateChapter = widget.bookEmail == ''
        ? await getChapterDetail(bookNo, chapterNo)
        : await getBookOtherChapterDetail(widget.bookEmail, bookNo, chapterNo);
    chapterModel = updateChapter;
    setState(() {
      chapterModel = updateChapter;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chapterModel = widget.chapterList[widget.idx]; // 완전히 로드 되기 전까지 null 에러 안나도록 호출
    _updateState(widget.bookNo, widget.chapterNo);
    _editorMode = widget.editorMode;
    titleFocusNode.addListener(_titleFieldFocusListener);
    contentsFocusNode.addListener(_contentFieldFocusListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleFocusNode.dispose();
    contentsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    noteEditScreen = NoteEditScreen(
      chapterModel: chapterModel,
      titleController: titleController,
      contentsController: contentsController,
      titleFocusNode: titleFocusNode,
      contentsFocusNode: contentsFocusNode,
    );
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
              child: Image.asset('images/icons/00_chapter_pre.png')),
          backgroundColor: Colors.black,
          title: Text('무제노트'),
          centerTitle: true,
          actions: <Widget>[
            ((Mnote.myEmail == widget.bookEmail) || (widget.bookEmail == '')) && _currentPageIndex == 0 ?
            FlatButton(
              child: Text(
                _editorMode ? '완료하기' : '수정하기',
                style: Mnote.appBarRightOkBtnText,
              ),
              onPressed: () => _editorModeChange(_editorMode),
            ): Row(),
            SizedBox(width: 20,)
          ],
        ),
        backgroundColor: Colors.white,
        body:
        widget.chapterList.length - 1 == widget.idx // 마지막인 페이지인 경우에만 우측 슬라이드 가능하도록 한다.
            ? PageView(
          onPageChanged: (index) => _onPageChanged(index),
          children: <Widget>[
            _editorMode
                ? noteEditScreen
                : Column(
              children: <Widget>[
                // 본문
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: (){
                      if ((Mnote.myEmail == widget.bookEmail) || (widget.bookEmail == '')){
                        _editorModeChange(false);
                      }
                    },
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          //minHeight: MediaQuery.of(context).size.height,
                        ),
                        child:  Column(
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
                                              child:
                                              Text(Mnote.getDateFormat_2(chapterModel.chapterStartDate), textAlign: TextAlign.justify,
                                                  style: Mnote.noteSubTitleFiledHint,)
                                            ),
                                            // 주황색 선
                                            OrangeLine(),
                                            SizedBox(height: 2,),
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
            NoteLastScreen(bookNo: widget.bookNo,)
          ],
        )
            : _editorMode
            ? noteEditScreen
            : Column(
          children: <Widget>[
            // 본문
            Expanded(
              child: GestureDetector(
                onDoubleTap: (){
                  if ((Mnote.myEmail == widget.bookEmail) || (widget.bookEmail == '')) {
                    _editorModeChange(false);
                  }
                },
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      //minHeight: MediaQuery.of(context).size.height,
                    ),
                    child:  Column(
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
                                          height: 12,
                                        ),
                                        // 날짜 영역
                                        Container(
                                          margin: EdgeInsets.only(bottom: 15),
                                          child: Text(Mnote.getDateFormat_2(chapterModel.chapterStartDate), textAlign: TextAlign.justify,
                                            style: Mnote.noteSubTitleFiledHint,)
                                        ),
                                        // 주황색 선
                                        OrangeLine(),
                                        SizedBox(height: 12,),
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
      ),
    );
  }
}

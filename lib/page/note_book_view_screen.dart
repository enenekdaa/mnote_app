import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/page/note_view_screen.dart';
import 'package:mnote_app/service/book_other_service.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'note_book_edit_screen.dart';

class NoteBookViewScreen extends StatefulWidget {
  final String bookNo;
  final String otherEmail; // 빈값 ('')일 경우 내글 보기 상태

  NoteBookViewScreen({
    this.bookNo,
    this.otherEmail=''
  });

  @override
  _NoteBookViewScreenState createState() => new _NoteBookViewScreenState();
}

class _NoteBookViewScreenState extends State<NoteBookViewScreen> {
  List<ChapterModel> chapterList = [];
  String bookTitle = '';
  String bookSubtitle = '';
  String bookShow = '';
  String bookEmail = '';
  String bookWriterName = '';

  // 책 정보 로드
  void _initBookInfo() async {
    if (widget.otherEmail == ''){
      BookModel book = await getBookInfoItem(widget.bookNo);
      chapterList = await getBookDetailItems(widget.bookNo);
      setState(() {
        bookTitle = book.bookTitle;
        bookSubtitle = book.bookSubtitle;
        bookShow = book.bookShow;
        bookEmail = book.email;
        bookWriterName = book.writerName;
      });
    }else{
      BookModel book = await getBookOtherWritingsDetail(widget.otherEmail, widget.bookNo);
      chapterList = await getBookOtherWritingsDetailList(widget.otherEmail, widget.bookNo);
      setState(() {
        bookTitle = book.bookTitle;
        bookSubtitle = book.bookSubtitle;
        bookShow = book.bookShow;
        bookEmail = book.email;
        bookWriterName = book.writerName;
      });
    }
  }

  // 챕터 클릭
  void _chapterClick(String chapterNo, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteViewScreen(
              bookNo: widget.bookNo,
              chapterNo: chapterNo,
              chapterList: chapterList,
              idx: index,
              editorMode: false,
              bookEmail: widget.otherEmail,
            ),
            settings: RouteSettings(name: '/daily_main')));
  }

  // 글쓰기 (챕터 생성)
  void _writeNewChapterClick() async {
    // TODO:: 글쓰기 new_chapter: null ERROR
    // flutter: http://icomerict.cafe24.com/untitled_note/json/write_new_chapter.php
    // flutter: {result: true, new_chapter: null}

    String chapterNo = await writeNewChapter(widget.bookNo);
    chapterList = await getBookDetailItems(widget.bookNo);

    if(chapterNo != 'fail'){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NoteViewScreen(bookNo: widget.bookNo, chapterNo: chapterNo, chapterList: chapterList, idx: chapterList.length-1, editorMode: true,),
              settings: RouteSettings(name: '/note_view')));
    }else{
      Fluttertoast.showToast(msg: '글쓰기 생성에 실패하였습니다.');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initBookInfo();
  }

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
          Mnote.myEmail == bookEmail
              ? FlatButton(child: Text('완결하기',style: Mnote.appBarRightOkBtnText,),onPressed: () => Navigator.pop(context),)
              : FlatButton(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
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
                      onTap: () {
                        // 노트북 수정 화면으로 이동
                        if (Mnote.myEmail == bookEmail){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => NoteBookEditScreen(bookNo: widget.bookNo)));
                        }
                      },
                      child: Text(bookTitle,
                        maxLines: 1,
                        style: Mnote.noteTitleFiledHint,
                      ),
                    ),
                    // 하루글감일 경우 서브 텍스트는 안보임
                    widget.bookNo == '1'
                      ? SizedBox()
                      : Text(bookSubtitle, style: Mnote.noteSubTitleFiledHint,),
                    // 내 노트목록일 경우 공개 버튼 / 오픈 공개 노트일 경우 작가이름
                    widget.otherEmail == ''
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // TODO:: 공개 비공개 API 연동
                            setState(() {
                              // bookShow = bookShow == '1' ? '2' : '1';
                            });
                          },
                          child: Image.asset(
                            bookShow == '1' ? 'images/icons/00_toggle_02_on.png' : 'images/icons/00_toggle_02_off.png',
                            scale: 1.8,
                          ),
                        ),
                      ],
                    )
                        : Row(crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[Text(bookWriterName, style: Mnote.textBlackUnder_16,),],)
                  ],
                ),
              ),
            ),
            Container(
              height: 0.2,
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.grey,
            ),
          widget.otherEmail == ''
              ? FlatButton(onPressed: () => _writeNewChapterClick(),
                            child: Text('+ 글쓰기',style: TextStyle(fontSize: 15, color: Mnote.orange),))
              : SizedBox(),
            Expanded(
                flex: 7,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: chapterList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _note(index, chapterList);
                    })),
          ],
        ),
      ),
    );
  }

  Widget _note(int index, List<ChapterModel> noteList) {
    return GestureDetector(
        onTap: () => _chapterClick(noteList[index].chapterNo, index),
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
              (index+1).toString().padLeft(2, '0'),
                style: TextStyle(color: Mnote.gray153),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  noteList[index].chapterTitle,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/page/note_view_screen.dart';
import 'package:mnote_app/service/book_other_service.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'note_book_edit_screen.dart';

class OpenNoteBookIntroScreen extends StatefulWidget {
  final String bookNo;
  final String email;

  OpenNoteBookIntroScreen({
    this.bookNo,
    this.email
  });

  @override
  _OpenNoteBookIntroScreenState createState() => new _OpenNoteBookIntroScreenState();
}

class _OpenNoteBookIntroScreenState extends State<OpenNoteBookIntroScreen> {
  String bookTitle = '';
  String bookSubtitle = '';
  String bookIntro = '';
  String bookWriterName = '';

  // 책 정보 로드
  void _initBookInfo() async {
    BookModel book = await getBookOtherIntroList(context, widget.email, widget.bookNo);

    setState(() {
      bookTitle = book.bookTitle;
      bookSubtitle = book.bookSubtitle;
      bookIntro = book.bookIntro;
      bookWriterName = book.writerName;
    });
  }

  // 글 상세 이동
  void _clickBookIntro(){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoteBookViewScreen(bookNo: widget.bookNo, otherEmail: widget.email,)));
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
          FlatButton(child: Text('작가 구독',style: Mnote.appBarRightOkBtnText,),onPressed: () => {},),
          SizedBox(width: 10,)
        ],
      ),
      backgroundColor: Mnote.nightModeBackgroundColor,
      body: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
        child:
        GestureDetector(
          onTap: _clickBookIntro,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.width / 15,),
              Text(bookTitle, maxLines: 1, style: TextStyle(fontSize: 24, color: Mnote.nightModeTextColor),),
              SizedBox(height: 10,),
              Text(bookSubtitle, style: Mnote.noteSubTitleFiledHint,),
              SizedBox(height: MediaQuery.of(context).size.width / 15,),
              Text(bookIntro, style: TextStyle(fontSize: 16, color: Mnote.nightModeTextColor),),
              SizedBox(height: MediaQuery.of(context).size.width / 15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(bookWriterName, style: TextStyle(fontSize: 16, color: Mnote.nightModeTextColor, decoration: TextDecoration.underline),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/widget/monote_line.dart';

class NoteLastScreen extends StatefulWidget {
  final String bookNo;
  NoteLastScreen({this.bookNo});

  @override
  _NoteLastScreenState createState() => _NoteLastScreenState();
}

class _NoteLastScreenState extends State<NoteLastScreen> {
  BookModel book;
  TextEditingController titleController = TextEditingController();
  bool visibilityEditor = false; // 내용입력 에디터 폼 보이기 on/off
  bool visibilityTime = true; // 노트 화면 > 시간 보이기 on/off

  // 책 정보 로드
  void _initBookInfo() async{
    BookModel newBook = await getBookInfoItem(widget.bookNo);
    setState(() {
      book = newBook;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    book = BookModel(
      bookTitle: '',
      bookSubtitle: '',
      bookStartDate: '',
      writerName: ''
    );
    _initBookInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // 제목
          Expanded(
            flex: 1,
            child: Text(' '),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  book != null ? book.bookTitle : '',
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
                    book != null ? book.bookSubtitle : '',
                    style: Mnote.noteSubTitleFiledHint,
                  ),
                ),
                // 주황색 선
                OrangeLine(),
                // 발행, 저자, 펴낸곳
                Row(
                  children: <Widget>[
                    Text('발행', style: Mnote.textHint_13_5,),
                    SizedBox(width: 10,),
                    Text(book != null ? book.bookStartDate : '', style: Mnote.textBlack_13_5),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('저자', style: Mnote.textHint_13_5,),
                    SizedBox(width: 10,),
                    Text(book != null ? book.writerName : '', style: Mnote.textBlack_13_5),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('펴낸곳', style: Mnote.textHint_13_5,),
                    SizedBox(width: 10,),
                    Text('무제노트', style: Mnote.textBlack_13_5),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('UNBN 19-004-000001', style: Mnote.noteSubTitleFiledHint,),
                SizedBox(height: 10,),
                Text('무제노트', style: Mnote.noteSubTitleFiled,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

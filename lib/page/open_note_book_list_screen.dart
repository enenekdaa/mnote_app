import 'package:flutter/material.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/page/open_note_book_intro.dart';
import 'package:mnote_app/service/book_other_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/widget/monote_line.dart';

class OpenNoteBookListScreen extends StatefulWidget {
  final String email;
  
  OpenNoteBookListScreen({this.email});
  
  @override
  _OpenNoteBookListScreenState createState() => new _OpenNoteBookListScreenState();
}

class _OpenNoteBookListScreenState extends State<OpenNoteBookListScreen> {

  List<BookModel> _otherNoteBookList = [];

  // 공개 노트 리스트 아이템 클릭
  void _openNoteBookClick(BookModel book) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OpenNoteBookIntroScreen(bookNo: book.bookNo, email: widget.email,)));
  }

  // 공개 노트 초기화
  void _initOtherNoteBooks() async{
    List<BookModel> bookList =  await getBookOtherList(widget.email);
    List<BookModel> tempList = [];
    bookList.forEach((book){
      if(book.bookTitle.trim() != '') {
        tempList.add(book);
      }
    });

    setState(() {
      _otherNoteBookList.clear();
      _otherNoteBookList.addAll(tempList);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initOtherNoteBooks();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(OpenNoteBookListScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Mnote.nightModeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:
        Builder(
          builder: (context) => FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Image.asset('images/icons/00_chapter_pre.png')),
        ),
        centerTitle: true,
        title: Text('무제노트',),
        actions: <Widget>[],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                height: maxHeight / 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '공개 노트',
                      style: TextStyle(color: Mnote.nightModeTextColor, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    OrangeLine()
                  ],
                )),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    children: List.generate(_otherNoteBookList.length, (index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: _makeOpenNoteBookList(index, _otherNoteBookList)
                      );
                    }))
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Open Note Book List
  Widget _makeOpenNoteBookList(int index, List<BookModel> noteList) {
    return GestureDetector(
      onTap: () => _openNoteBookClick(noteList[index]), // 노트북 수정/삭제 다이얼로그,
      child: _noteBox(noteList[index]),
    );
  }

  // Note BOX
  Widget _noteBox(BookModel book) {
    String _bookCoverImgNo = book.bookCoverImgNo == '' || book.bookCoverImgNo == null ? '1': book.bookCoverImgNo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 4.25,
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('http://icomerict.cafe24.com/untitled_note/cover/$_bookCoverImgNo.jpg'),
                // image: NetworkImage('http://icomerict.cafe24.com/untitled_note/cover/1.jpg'),
                fit: BoxFit.cover
            ),
            //color: Colors.black12
          ),
// 책 제목 영역
//          child: Text(
//            title,
//            style: Mnote.noteBoxTitleText,
//            maxLines: 2,
//            overflow: TextOverflow.ellipsis,
//          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.5,
          child: Text(
            book.bookTitle,
            style: TextStyle(fontSize: 15, color: Mnote.nightModeTextColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

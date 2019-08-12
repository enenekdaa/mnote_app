import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/page/daily_main_screen.dart';
import 'package:mnote_app/page/open_list_screen.dart';
import 'package:mnote_app/service/books_my_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/dialog/note_book_modify_dialog.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/widget/monote_line.dart';
import 'daily_view_list_screen.dart';

class NoteBookListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteBookListScreenState();
}

class _NoteBookListScreenState extends State<NoteBookListScreen> with WidgetsBindingObserver{
  List<BookModel> _myNoteBookList = [];
  List<BookModel> _openNoteBookList = [];

  // 노트북 수정/삭제 다이얼로그
  void _showNoteBookModifyDialog(String bookNo) {
    if(bookNo == '1'){
      return;
    }
    showDialog(
      context: context,
      builder: (_) => NoteBookModifyDialog(bookNo: bookNo,),
    );
  }

  // 공개 노트 리스트 아이템 클릭
  void _openNoteBookClick(BookModel book) {

    // 공개 노트인 경우
    if(book.bookNo == '0'){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OpenListScreen(),
              settings: RouteSettings(name: '/open_list'))
      );
    }

    // 하루 글감인 경우
    if(book.bookNo == '1'){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DailyViewListScreen(),
              settings: RouteSettings(name: '/main/daily_view_list')));
    }
  }

  // 내 노트 리스트 중 클릭
  void _myNoteBookClick(BookModel book){
    // 하루 글감인 경우
    if(book.bookNo == '1'){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DailyMainScreen(noteTitle: book.bookTitle,),
              settings: RouteSettings(name: '/daily_main')));
    }else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoteBookViewScreen(bookNo: book.bookNo,)));
    }
  }

  // 나의 노트 초기화
  void _initMyNoteBooks() async{
    List<BookModel> bookList =  await getBooksMy();
    _myNoteBookList.clear();
    bookList.forEach((book){
      if(book.bookTitle.trim() != '') {
        _myNoteBookList.add(book);
      }
    });
    // 서버에서 값 가져오는 시간
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _myNoteBookList.add(BookModel(bookTitle: ''));
      });
    });
  }

  // 오픈 노트 초기화
  void _initOpenNoteBooks(){
    _openNoteBookList.add(BookModel(bookTitle: '하루 글감', bookNo: '1'));
    _openNoteBookList.add(BookModel(bookTitle: '공개 글 모아보기', bookNo: '0'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initMyNoteBooks();
    _initOpenNoteBooks();
  }

  @override
  void didUpdateWidget(NoteBookListScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('note_book_list_screen didUpdateWidget');
    setState(() {
      _initMyNoteBooks();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO:: 노트 삭제 되었을때 화면 업데이트 되도록 수정해야함
    print('note_book_list_screen didChangeAppLifecycleState');
//    setState(() {
//      print(state);
//      _initMyNoteBooks();
//    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '나의 노트',
                      style: Mnote.textFiledLabel,
                    ),
                    OrangeLine()
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _myNoteBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _makeMyNoteBookList(index, _myNoteBookList);
                  }),
            ),
          ),
          GrayDivider(),
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '공개 노트',
                            style: Mnote.textFiledLabel,
                          ),
                        ),
                        /*SizedBox(
                          width: 68,
                          height: 25,
                          child: GestureDetector(
                            onTap: () => {},
                            child: Image.asset('images/icons/00_btn_more.png'),
                          ),
                        ),*/
                      ],
                    ),
                    OrangeLine()
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _openNoteBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _makeOpenNoteBookList(index, _openNoteBookList);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  // My Note Book List
  Widget _makeMyNoteBookList(int index, List<BookModel> noteList) {
    return noteList[index].bookTitle != ''
        ? GestureDetector(
      onLongPress: () => _showNoteBookModifyDialog(noteList[index].bookNo),
      onTap: () => _myNoteBookClick(noteList[index]),
      // 노트북 수정/삭제 다이얼로그,
      child: _noteBox(noteList[index]),
    )
        : Column(
      // 나의 노트에서 맨 마지막일 경우 [+] 버튼 추가 (맨 마지막 구분자로 확인할수 있다.)
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20, bottom: 10),
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 5.75,
            width: MediaQuery.of(context).size.width / 3.5,
            child: FlatButton(
              onPressed: () => {MyNavigator.goToNoteBookEdit(context)},
              child: Image.asset(
                'images/icons/00_main_add.png',
                scale: 1.8,
              ),
            )),
      ],
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
          margin: EdgeInsets.only(right: 30, bottom: 10),
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 5.75,
          width: MediaQuery.of(context).size.width / 3.5,
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
            style: Mnote.noteBoxBottomText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

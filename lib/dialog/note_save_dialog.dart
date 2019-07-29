import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/service/books_my_service.dart';

import 'package:mnote_app/utils/my_navigator.dart';

class NoteSaveDialog extends StatefulWidget {
  final String title;
  final String contents;

  NoteSaveDialog(this.title, this.contents);

  @override
  _NoteSaveDialogState createState() => _NoteSaveDialogState();
}

class _NoteSaveDialogState extends State<NoteSaveDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  List<BookModel> _myNoteBookList = [];

  // 나의 노트 리스트 설정
  void _initMyNoteBooks() async{
    List<BookModel> bookList =  await getBooksMy();
    bookList.forEach((book){
      if(book.bookTitle.trim() != '' && book.bookNo != '1') {
        _myNoteBookList.add(book);
      }
    });
  }

  // 챕터 저장
  void _saveChapter(String bookNo) async {
    String result = writeNewChapter(bookNo) as String;
    if (result != 'fail'){
      _updateChapter(bookNo, result);
    }else{
      Fluttertoast.showToast(msg: '챕터 신규 생성에 실패하였습니다.');
    }
  }

  // 챕터 업데이트
  void _updateChapter(String bookNo, String chapterNo) async {
    String result = updateChapter(bookNo, chapterNo, widget.title, widget.contents, '0') as String;
    if (result != 'fail'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteBookViewScreen(bookNo: bookNo)));
    }else{
      Fluttertoast.showToast(msg: '챕터 수정에 실패하였습니다.');
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();

    _initMyNoteBooks();
  }

  @override
  Widget build(BuildContext context) {
    final maxSize = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: maxSize / 1.3,
            height: maxSize / 1.55,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("저장할 노트를 선택하세요"),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _myNoteBookList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: maxSize,
                            height: 50,
                            padding: EdgeInsets.only(bottom: 6, left: 10, right: 10),
                            child: MaterialButton(
                              child: Text(_myNoteBookList[index].bookTitle),
                              onPressed: () => _saveChapter(_myNoteBookList[index].bookNo),
                              elevation: 0,
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                          );
                        }),
                  ),
                  Container(
                    width: maxSize,
                    height: 55,
                    padding: EdgeInsets.only(top:6, bottom: 6, left: 10, right: 10),
                    child: MaterialButton(
                        elevation: 0,
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () => {
                          MyNavigator.goToNoteBookEdit(context)
                        },
                        child: Text(' + 새노트 작성')),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    elevation: 0,
                    color: Colors.white,
                    minWidth: maxSize,
                    child: Text('취소',),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

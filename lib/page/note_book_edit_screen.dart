import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/dialog/note_cover_dialog.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/service/books_my_service.dart';
import 'package:mnote_app/utils/mnote.dart';

import 'note_book_view_screen.dart';

class NoteBookEditScreen extends StatefulWidget {
  final String bookNo;

  NoteBookEditScreen({this.bookNo});

  @override
  _NoteBookEditScreenState createState() => new _NoteBookEditScreenState();
}

class _NoteBookEditScreenState extends State<NoteBookEditScreen> {
  String bookTitle;
  String bookSubTitle;
  String bookIntro;
  String bookShow = '1';

  TextEditingController bookTitleTextEditController = new TextEditingController();
  TextEditingController bookSubTitleTextEditController = new TextEditingController();
  TextEditingController bookIntroTextEditController = new TextEditingController();


  void _showNoteCoverDialog() {
    showDialog(context: context, builder: (_) => NoteCoverDialog());
  }

  void _initBookInfo() async {
    //BookModel bookInfo = await getBookInfoItem(context, widget.bookNo);
    BookModel bookInfo = await getBooksMyIntro(context, widget.bookNo);
    setState(() {
      bookTitle = bookInfo.bookTitle;
      bookSubTitle = bookInfo.bookSubtitle;
      bookIntro = bookInfo.bookIntro;
      bookShow = bookInfo.bookShow;
      bookTitleTextEditController.text = bookTitle;
      bookSubTitleTextEditController.text = bookSubTitle;
      bookIntroTextEditController.text = bookIntro;
    });
  }

  void _writeBookMy() async{
    String saveBookTitle = bookTitleTextEditController.text.trim();
    String saveBookSubTitle = bookSubTitleTextEditController.text.trim();
    String saveBookIntro = bookIntroTextEditController.text.trim();

    if (saveBookTitle == '') {
      Fluttertoast.showToast(msg: '빈칸 없이 입력해주세요.');
      return;
    }

    // TODO:: coverImgNo 설정하기
    String newBook = await writeNewBook(context, saveBookTitle, saveBookSubTitle, saveBookIntro, '2', bookShow);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteBookViewScreen(bookNo: newBook)));
  }

  void _updateBook() async{
    String saveBookTitle = bookTitleTextEditController.text.trim();
    String saveBookSubTitle = bookSubTitleTextEditController.text.trim();
    String saveBookIntro = bookIntroTextEditController.text.trim();

    if (saveBookTitle == '') {
      Fluttertoast.showToast(msg: '빈칸 없이 입력해주세요.');
      return;
    }

    // TODO:: coverImgNo 설정하기
    String updateBookResult = await updateBook(context, widget.bookNo, saveBookTitle, saveBookSubTitle, saveBookIntro, '1', bookShow);

    if (updateBookResult == 'true'){
      Fluttertoast.showToast(msg: '성공적으로 수정되었습니다.');
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteBookViewScreen(bookNo: widget.bookNo)));
    }
    else{
      Fluttertoast.showToast(msg: '수정에 실패하였습니다.');
    }
  }

  void _updateBookShowState(String show) async {
    await updateBookShowState(context, widget.bookNo, show);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bookNo 의 값이 null 일 경우에는 새노트 작성이다.
    // bookNo 값이 있을 경우에는 노트 수정이다.
    if (widget.bookNo != null) {
      _initBookInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_chapter_pre.png')),
        backgroundColor: Colors.black,
        title: Text('무제노트'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              '저장하기',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () {
              widget.bookNo == null ? _writeBookMy() : _updateBook();
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: deviceHeight - deviceHeight/10
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.all(deviceHeight / 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextField(
                          maxLines: 1,
                          style: Mnote.noteTitleFiledHint,
                          controller: bookTitleTextEditController,
                          decoration: InputDecoration(
                              hintText:
                              bookTitle == null ? '노트 제목을 입력해주세요.' : bookTitle,
                              hintStyle: Mnote.noteTitleFiledHint,
                              border: InputBorder.none),
                        ),
                        TextField(
                          minLines: 1,
                          style: Mnote.noteSubTitleFiledHint,
                          controller: bookSubTitleTextEditController,
                          decoration: InputDecoration(
                              hintText: bookSubTitle == null
                                  ? '소제목을 입력해주세요.'
                                  : bookSubTitle,
                              hintStyle: Mnote.noteSubTitleFiledHint,
                              border: InputBorder.none),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _showNoteCoverDialog(),
                              child: Image.asset(
                                'images/icons/07_btn_cover.png',
                                scale: 1.8,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                _updateBookShowState(bookShow == '1' ? '0' : '1');
                                setState(() {
                                  bookShow = bookShow == '1' ? '2' : '1';
                                });
                              },
                              child: Image.asset(
                                bookShow == '1'
                                    ? 'images/icons/00_toggle_02_on.png'
                                    : 'images/icons/00_toggle_02_off.png',
                                scale: 1.8,
                              ),
                            ),
//
//                        Expanded(child: MergeSemantics(
//                          child: ListTile(
//                            trailing: CupertinoSwitch(
//                              value: _value1,
//                              onChanged: (bool value) {
//                                setState(() {
//                                  _value1 = value;
//                                });
//                              },
//                            ),
//                            onTap: () {
//                              setState(() {
//                                _value1 = !_value1;
//                              });
//                            },
//                          ),
//                        ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.2,
                  color: Colors.grey,
                ),
                Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.all(deviceHeight / 80),
                      child: TextField(
                        maxLines: 1,
                        controller: bookIntroTextEditController,
                        decoration: InputDecoration(
                            hintText: bookIntro == null ? '노트에 대한 간단한 소개를 입력해 주세요.' : bookIntro,
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

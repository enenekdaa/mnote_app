import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/page/note_view_screen.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class DailyMyScreen extends StatefulWidget {
  @override
  _DailyMyScreenState createState() => new _DailyMyScreenState();
}

class _DailyMyScreenState extends State<DailyMyScreen> {
  List<ChapterModel> chapterList = [];
  String bookTitle = '';
  String bookSubtitle = '';
  String bookShow = '';

  // 챕터 클릭
  void _chapterClick(String chapterNo, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteViewScreen(bookNo: '1',chapterNo: chapterNo, chapterList: chapterList, idx: index, editorMode: false,),
            settings: RouteSettings(name: '/note_view')));
  }

  // 하루글감 정보 로드
  void _initBookInfo() async {
    BookModel book = await getDailyInfoItem(context, );
    chapterList = await getDailyDetailItems(context, );
    setState(() {
      bookTitle = book.bookTitle;
      bookSubtitle = book.bookSubtitle;
      bookShow = book.bookShow;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('하루 글감 화면 (내 글 리스트) - daily_my_screen');
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
        title: Text('무제 노트'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              '글감목록',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => MyNavigator.goToDailyList(context),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        color: Mnote.nightModeBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 25,
                    bottom: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => {MyNavigator.goToNoteBookEdit(context)},
                      child: Text(
                        bookTitle,
                        style: TextStyle(fontSize: 24, color: Mnote.nightModeTextColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => {},
                          child: Text(bookSubtitle,style: TextStyle(decoration: TextDecoration.underline, fontSize: 16, color: Mnote.nightModeTextColor),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 0.2,
              margin: EdgeInsets.only(bottom: 20),
              color: Colors.grey,
            ),
            Expanded(
                flex: 5,
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
              Text(noteList[index].chapterStartDate, style: TextStyle(color: Mnote.gray153),),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Text(
                  noteList[index].chapterTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Mnote.nightModeTextColor, fontSize: 16), //Mnote.mnoteBlack
                ),
              ),
            ],
          ),
        ));
  }
}

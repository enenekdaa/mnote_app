import 'package:flutter/material.dart';
import 'package:mnote_app/dialog/note_save_dialog.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/dialog/report_dialog.dart';
import 'package:mnote_app/utils/mnote.dart';

import 'navigation_screen.dart';
import 'note_edit_screen.dart';
import 'note_book_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  int currentPageIndex = 0; // 현재 화면 페이지

  TextEditingController titleController = TextEditingController(); // 제목 컨트롤러
  TextEditingController contentsController = TextEditingController(); // 본문 컨트롤러

  void _onContentDoubleTap(bool visibilityTime) {
    setState(() {
      visibilityEditFinishBtn = visibilityTime;
    });
  }

  void _onPageChanged(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavigationScreen(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:
          Builder(
            builder: (context) => FlatButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: Image.asset('images/icons/00_top_menu.png')),
          ),
        title: Text('무제노트',),
        actions: <Widget>[
          // 작성완료 버튼 보임/숨김 처리
          visibilityEditFinishBtn || currentPageIndex == 1
              ? FlatButton(
                  child: Text(''),
                  onPressed: () => null,
                )
              : FlatButton(
                  child: Text('작성완료', style: Mnote.appBarRightOkBtnText),
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => NoteSaveDialog(titleController.text, contentsController.text),
                    );
                  },
                )
        ],
      ),
      body: PageView(
        onPageChanged: (index) => _onPageChanged(index),
        children: <Widget>[
          // 노트 입력 화면
          NoteEditScreen(
            contentDoubleTabCallback: _onContentDoubleTap,
            titleController: titleController,
            contentsController: contentsController,
          ),
          // 나의 노트 화면
          NoteBookListScreen(),
        ],
      ),
    );
  }
}


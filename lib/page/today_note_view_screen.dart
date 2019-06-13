import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/widget/monote_line.dart';

import 'note_edit_screen.dart';
import 'note_last_screen.dart';

class TodayNoteViewScreen extends StatefulWidget {

  TodayNoteViewScreen();

  @override
  _TodayNoteViewScreenState createState() => _TodayNoteViewScreenState();
}

class _TodayNoteViewScreenState extends State<TodayNoteViewScreen> {

  bool _visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  bool _editorMode = false;    // 에디터 모드

  int _currentPageIndex = 0;

  void _onContentDoubleTap(bool visibilityTime) {
    setState(() {
      _visibilityEditFinishBtn = visibilityTime;
    });
  }


  void _editorModeChange() {
    setState(() {
      _editorMode = !_editorMode;
    });
  }

  void _onPageChanged(int index){
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_top_menu.png')),
        backgroundColor: Colors.black,
        title: Text('하루 글감'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('글작성',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => MyNavigator.goToTodayNoteEdit(context),
          ),
          SizedBox(width: 20,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(38),
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('오후네시', style: TextStyle(decoration: TextDecoration.underline, ),),
                    Image.asset('images/icons/00_text_component_01.png',scale: 1.2,)
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20,),
                Text('우연', style: Mnote.textBlack_20,),
                SizedBox(height: MediaQuery.of(context).size.height / 35,),
                Text('우연이라 하기엔 너무나 심각했지 \n 우린 서로가 서로를 모른척을 해야만 했어 \n 변해버린 모습과 서로 다른 연인과 \n 같은 영화를 보러 갔다 우린 마주쳤었지 \n너와 눈이 마주치던 그순간 \n 나는 태연한척 하려 애를 썼지만 ...' +
                    '우연이라 하기엔 너무나 심각했지 \n 우린 서로가 서로를 모른척을 해야만 했어 \n 변해버린 모습과 서로 다른 연인과 \n 같은 영화를 보러 갔다 우린 마주쳤었지 \n너와 눈이 마주치던 그순간 \n 나는 태연한척 하려 애를 썼지만 ...',
                      style: TextStyle(color: Mnote.gray153, fontSize: 16, height: 1.5,),
                      textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 35,),
                Text('2019.05.23', style: Mnote.textHint_13_5,),
              ],
            ),

          ),
        ),
      ),
    );
  }
}

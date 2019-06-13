import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class TodayNoteListScreen extends StatefulWidget {
  @override
  _TodayNoteListScreenState createState() => new _TodayNoteListScreenState();
}

class _TodayNoteListScreenState extends State<TodayNoteListScreen> {
  List<String> _noteList = [
    '그리움',
    '사과',
    '딸기',
    '선풍기',
    '비',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
    '하루 글감',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_chapter_pre.png')),
        backgroundColor: Colors.black,
        title: Text('하루 글감'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(right: 30),
            child: Text('글작성', style: Mnote.appBarRightOkBtnText),
            onPressed: ()=>{MyNavigator.goToTodayNoteEdit(context)},
          )
        ],
      ),
      body: Container(
        color:  Mnote.gray245,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 14),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('2019.05.23', style: TextStyle(color: Mnote.gray153),),
                  Image.asset('images/icons/11_btn_wording.png', scale: 1.6,)
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _noteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _note(index, _noteList);
                    }),
              )
            ],
          )
      ),
      floatingActionButton: FlatButton(onPressed: ()=>{}, child: Image.asset('images/icons/00_btn_top.png', scale: 1.6,)),
    );
  }

  Widget _note(int index, List<String> noteList) {
    return GestureDetector(
        onTap: () => MyNavigator.goToTodayNoteView(context),
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Mnote.black, width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/icons/00_text_component_01.png',scale: 1.2,)
                ],
              ),
              Expanded(
                child: Text('우연', style: Mnote.textBlack_20,),),
              Expanded(
                flex: 5,
                child: Text(
                  '우연이라 하기엔 너무나 심각했지 \n 우린 서로가 서로를 모른척을 해야만 했어 \n 변해버린 모습과 서로 다른 연인과 \n 같은 영화를 보러 갔다 우린 마주쳤었지 \n너와 눈이 마주치던 그순간 \n 나는 태연한척 하려 애를 썼지만 ...',
                  style: TextStyle(color: Mnote.gray153, fontSize: 16, height: 1.5,),
                  textAlign: TextAlign.center,),
              ),
              Expanded(
                child: Text('오후네시', style: TextStyle(decoration: TextDecoration.underline, ),),
              )
            ],
          ),

        )
    );
  }
}

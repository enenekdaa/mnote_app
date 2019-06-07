import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/widget/monote_line.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class NoteLastScreen extends StatefulWidget {
  ContentDoubleTabHandler contentDoubleTabCallback;

  NoteLastScreen({this.contentDoubleTabCallback});

  @override
  _NoteLastScreenState createState() => _NoteLastScreenState();
}

class _NoteLastScreenState extends State<NoteLastScreen> {
  TextEditingController titleController = TextEditingController();
  final FocusNode _contentFieldFocusNode = FocusNode();

  bool visibilityEditor = false; // 내용입력 에디터 폼 보이기 on/off
  bool visibilityTime = true; // 노트 화면 > 시간 보이기 on/off

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentFieldFocusNode.addListener(_contentFieldFocusListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contentFieldFocusNode.dispose();
    super.dispose();
  }

  void _contentFieldFocusListener() {
    print('1');
    print("Has focus: ${_contentFieldFocusNode.hasFocus}");
    setState(() {
      visibilityEditor = _contentFieldFocusNode.hasFocus;
    });
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
                  '잘돼가? 무엇이든',
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
                    '이경미 첫 번째 에세이',
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
                    Text('2019년 04월 09일', style: Mnote.textBlack_13_5),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('저자', style: Mnote.textHint_13_5,),
                    SizedBox(width: 10,),
                    Text('이경미', style: Mnote.textBlack_13_5),
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

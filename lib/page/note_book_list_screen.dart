import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/dialog/note_book_modify_dialog.dart';
import 'package:mnote_app/widget/monote_line.dart';

class NoteBookListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteBookListScreenState();
}

class _NoteBookListScreenState extends State<NoteBookListScreen> {
  List<String> _myNoteList = ['dongdong', '아이디최대자리가많이차지하는책은처리', '사계', ''];
  List<String> _openNoteList = ['하루글', '스프의 위로'];

  // 노트북 수정/삭제 다이얼로그
  void _showNoteBookModifyDialog(String noteName) {
    showDialog(
      context: context,
      builder: (_) => NoteBookModifyDialog(noteName: noteName),
    );
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
                  itemCount: _myNoteList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _noteBox(index, _myNoteList);
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
                        SizedBox(
                          width: 68,
                          height: 25,
                          child: FlatButton(
                            shape: StadiumBorder(side: BorderSide(width: 0.5)),
                            child: Text('more'),
                          ),
                        ),
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
                  itemCount: _openNoteList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _noteBox(index, _openNoteList);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  // 노트북 BOX
  Widget _noteBox(int index, List<String> noteList) {
    return noteList[index] != ''
        ? GestureDetector(
            onLongPress: () => _showNoteBookModifyDialog(noteList[index]), // 노트북 수정/삭제 다이얼로그,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(right: 20, bottom: 10),
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height / 5.75,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Text(
                    noteList[index],
                    style: Mnote.noteBoxTitleText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Text(
                    noteList[index],
                    style: Mnote.noteBoxBottomText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
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
                    onPressed: () => {print('추가추가')},
                    child: Image.asset(
                      'images/icons/00_main_add.png',
                      scale: 1.8,
                    ),
                  )),
            ],
          );
  }
}

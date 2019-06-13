import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/dialog/note_cover_dialog.dart';
import 'package:mnote_app/utils/mnote.dart';

class NoteBookEditScreen extends StatefulWidget {
  @override
  _NoteBookEditScreenState createState() => new _NoteBookEditScreenState();
}

class _NoteBookEditScreenState extends State<NoteBookEditScreen> {
  bool _value1 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);

  void _showNoteCoverDialog(){
    showDialog(
        context: context,
        builder: (_) => NoteCoverDialog()
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextField(
                      maxLines: 1,
                      style: Mnote.noteTitleFiledHint,
                      decoration: InputDecoration(
                          hintText: '잘돼가? 무엇이든',
                          hintStyle: Mnote.noteTitleFiledHint,
                          border: InputBorder.none),
                    ),
                    TextField(
                      minLines: 1,
                      style: Mnote.noteSubTitleFiledHint,
                      decoration: InputDecoration(
                          hintText: '이경미 첫 번째 에세이',
                          hintStyle: Mnote.noteSubTitleFiledHint,
                          border: InputBorder.none),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: ()=>_showNoteCoverDialog(),
                          shape: StadiumBorder(),
                          minWidth: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 31,
                          elevation: 0,
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Text('표지만들기', style: Mnote.toggleBtnWText,),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: ()=>{},
                          child: Image.asset('images/icons/00_toggle_02_on.png', scale: 1.8,),
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
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: '노트에 대한 간단한 소개를 입력해 주세요.',
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

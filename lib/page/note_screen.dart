import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _value1 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_top_menu.png')),
        backgroundColor: Colors.black,
        title: Text('무제노트'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '완결하기',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
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
                    Text(
                      '잘돼가? 무엇이든',
                      style: Mnote.noteTitleFiledHint,
                    ),
                    Text(
                      '이경미 첫번째 이야기',
                      style: Mnote.noteSubTitleFiledHint,
                    ),
                    MergeSemantics(
                      child: ListTile(
                        trailing: CupertinoSwitch(
                          value: _value1,
                          onChanged: (bool value) {
                            setState(() {
                              _value1 = value;
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            _value1 = !_value1;
                          });
                        },
                      ),
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

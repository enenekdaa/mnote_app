import 'package:flutter/material.dart';

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
        leading:
            FlatButton(onPressed: () => Navigator.pop(context), child: null),
        actions: <Widget>[
          FlatButton(
            child: Text('완결하기'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30, top: 10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('가져온 제목' , style: TextStyle(fontSize: 50  ),),
                  Text('가져온 소제목' , style: TextStyle(fontSize: 30),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: _value1,
                        onChanged: _value1Changed,
                        checkColor: Colors.black,
                        activeColor: Colors.purple,
                      ),
                      Text('공개하기'),
                    ],
                  ),
                  Container(height: 2, color: Colors.grey,) ,
                ],
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: 25,
                decoration: InputDecoration(hintText: '내용 입력...', filled: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            FlatButton(onPressed: () => Navigator.pop(context), child: null),
        title: Text('무제노트'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: '제목을 입력...'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30, top: 10),
              alignment: Alignment(-1, 0),
              child: Text('2002-0505-02'),
            ),
            Expanded(
              child: TextField(
                maxLines: 20,
                decoration: InputDecoration(hintText: '내용 입력...' , filled: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

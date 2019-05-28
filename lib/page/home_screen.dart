import 'package:flutter/material.dart';
import 'package:mnote_app/utils/custom_dialog.dart';
import 'package:mnote_app/utils/m_navigator.dart';
import 'package:mnote_app/utils/report_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _data = ['tttt', 'rrrrr', 'ddddd'];

  bool visibilityTime = false;

  void _changed(bool visibility, String field) {
    if (visibilityTime) {
      visibility = false;
    } else {
      visibility = true;
    }
    setState(() {
      if (field == 'double') {
        visibilityTime = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('무제노트'),
        actions: <Widget>[
          visibilityTime
              ? FlatButton(
                  child: Text(''),
                  onPressed: () => null,
                )
              : FlatButton(
                  child: Text('작성완료'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => MainDialog(),
                    );
                  },
                )
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        '무제노트',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () =>
                                  MyNavigator.goToAppSetting(context),
                              child: Text(
                                '앱 설정',
                              ),
                            ),
                          ),
                          Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () => MyNavigator.goToPremium(context),
                              child: Text(
                                '프리미엄 구매',
                              ),
                            ),
                          ),
                          Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => ReportDialog(),
                                );
                              },
                              child: Text(
                                '하루 글감 제보',
                              ),
                            ),
                          ),
                          Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: null,
                              child: Text(
                                '책 만들기',
                              ),
                            ),
                          ),
                          Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment(1, -1),
                padding: EdgeInsets.all(30),
                child: FlatButton(
                  onPressed: () => MyNavigator.goToProfile(context),
                  child: Text(
                    '내 프로필 설정',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: '제목을 입력...'),
                ),
                visibilityTime
                    ? Container(
                        margin: EdgeInsets.only(bottom: 30, top: 10),
                        alignment: Alignment(-1, 0),
                        child: Text('2002-0505-02'),
                      )
                    : Container(),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () => _changed(true, 'double'),
                    child: TextField(
                      maxLines: 25,
                      decoration:
                          InputDecoration(hintText: '내용 입력...', filled: true),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 30, top: 10),
                  alignment: Alignment(-1, 0),
                  child: Text(
                    '나의 노트',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _oneData(index);
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30, top: 10),
                  alignment: Alignment(-1, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '공개 노트',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      FlatButton(
                        child: Text('more'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _oneData(index);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _oneData(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(height: 150, width: 160.0, color: Colors.red),
          Text(_data[index]),
        ],
      ),
    );
  }
}

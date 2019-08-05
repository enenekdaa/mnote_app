import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/model/daily_writings.dart';
import 'package:mnote_app/page/daily_edit_screen.dart';
import 'package:mnote_app/page/daily_view_list_screen.dart';
import 'package:mnote_app/page/daily_view_screen.dart';
import 'package:mnote_app/service/daily_list_service.dart';
import 'package:mnote_app/service/daily_today_service.dart';
import 'package:mnote_app/service/daily_writings_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';

class DailyListScreen extends StatefulWidget {
  @override
  _DailyListScreenState createState() => new _DailyListScreenState();
}

class _DailyListScreenState extends State<DailyListScreen> {
  int pageNo = 0;
  List<DailyModel> dailyList = [];
  List<DailyModel> duplicateItems = []; // 검색어 필터 / 원본 보관용
  TextEditingController searchEditTextController = TextEditingController();
  bool isSearchMode = false; // 검색 활성화 / 비활성화

  // 리스트 조회 (초기화)
  void _initDailyList() async {
    List<DailyModel> newDailyList = await getDailyList('0');
    setState(() {
      dailyList.addAll(newDailyList);
      ;
      duplicateItems.addAll(newDailyList);
    });
  }

  // 하루글감 아이템 클릭시 이동
  void _dailyItemClick(String dailyListNo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DailyViewListScreen(
              dailyListNo: dailyListNo,
            )
        )
    );
  }

  // 검색어 필터
  void _filterSearchResults(String query) {
    List<DailyModel> dummySearchList = List<DailyModel>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<DailyModel> dummyListData = List<DailyModel>();
      dummySearchList.forEach((item) {
        if (item.dailyTitle.contains(query) ||
            item.dailySentence.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        dailyList.clear();
        dailyList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        dailyList.clear();
        dailyList.addAll(duplicateItems);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDailyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearchMode
          ? AppBar(
        leading: Row(),
        backgroundColor: Colors.black,
        title: TextField(
          onChanged: (value) {
            print(value);
            _filterSearchResults(value);
          },
          controller: searchEditTextController,
          decoration: InputDecoration(
            hintText: "검색어를 입력해주세요.",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            child: Image.asset('images/icons/11_search_eraser.png'),
            onPressed: () {
              setState(() {
                isSearchMode = false;
              });
            },
          )
        ],
      )
          : AppBar(
        leading: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset('images/icons/00_chapter_pre.png')),
        backgroundColor: Colors.black,
        title: Text('글감 목록'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isSearchMode = true;
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView.builder(
          //shrinkWrap: true,
          itemCount: dailyList.length,
          itemBuilder: (context, index) {
            return _note(index, dailyList);
          },
        ),
      ),
      floatingActionButton: FlatButton(
          onPressed: () => {},
          child: Image.asset(
            'images/icons/00_btn_top.png',
            scale: 1.6,
          )),
    );
  }

  Widget _note(int index, List<DailyModel> noteList) {
    return GestureDetector(
        onTap: () => _dailyItemClick(noteList[index].dailyListNo),
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.width / 2.7,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Mnote.black, width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    noteList[index].dailyTitle,
                    style: Mnote.noteBoxBottomText,
                  ),
                  Text(
                    Mnote.getDateFormat_1(noteList[index].dailyDate),
                    style: Mnote.textHint_13_5,
                  ),
                ],
              ),
              Text(
                noteList[index].dailySentence,
                style: TextStyle(
                  color: Mnote.gray153,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '공개 ${noteList[index].showCount}개 | ',
                    style: Mnote.textBlack_13_5,
                  ),
                  Text(
                    '${noteList[index].allCount}개 글',
                    style: Mnote.textBlack_13_5,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

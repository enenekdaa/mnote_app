import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/model/writer_all.dart';
import 'package:mnote_app/service/writer_list_service.dart';
import 'package:mnote_app/utils/mnote.dart';

class OpenListScreen extends StatefulWidget {
  @override
  _OpenListScreenState createState() => new _OpenListScreenState();
}

class _OpenListScreenState extends State<OpenListScreen> {
  int newPageNo = 1;
  int subPageNo = 1;
  List<WriterAll> tapList = []; // 현재 선택된 탭
  List<WriterAll> writerAllList = []; // 전체 작가
  List<WriterAll> writerSubList = []; // 구독 작가
  List<WriterAll> duplicateItems = []; // 검색어 필터 / 원본 보관용
  TextEditingController searchEditTextController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  bool isSearchMode = false; // 검색 활성화 / 비활성화
  bool isAllList = true; // 작가 목록 탭 = true, 구독중 탭 = false

  // 리스트 조회 (초기화) 기본 전체 작가
  void _initDailyList() async {
    List<WriterAll> newList = await getWriterListAll(newPageNo.toString());
    List<WriterAll> subList = await getWriterListSub(newPageNo.toString());
    setState(() {
      tapList.addAll(newList);
      writerAllList.addAll(newList);
      writerSubList.addAll(subList);
      duplicateItems.addAll(newList);
    });
    newPageNo++;
    subPageNo++;
  }
  
  // 작가 목록 데이터 가져오기 (무한로딩)
  void _initNewList() async {
    List<WriterAll> newList = await getWriterListAll(newPageNo.toString());
    print('_initNewList $newPageNo');
    if (newList.length > 0){
      setState(() {
        writerAllList.addAll(newList);
        duplicateItems.addAll(newList);
        tapList.addAll(newList);
      });
      newPageNo++;
    }
  }
  
  
  // 작가 목록 데이터 가져오기 (무한로딩)
  void _initSubList() async {
    List<WriterAll> subList = await getWriterListSub(newPageNo.toString());
    print('_initNewList $subPageNo');
    if (subList.length > 0){
      setState(() {
        writerSubList.addAll(subList);
        tapList.addAll(subList);
      });
      subPageNo++;
    }
  }
  
  

  // 하루글감 아이템 클릭시 이동
  void _writerListItemClick(String email) {
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => DailyViewListScreen(
//                  dailyListNo: dailyListNo,
//                )));
  }

  // 검색어 필터
  void _filterSearchResults(String query) {
    List<WriterAll> dummySearchList = List<WriterAll>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<WriterAll> dummyListData = List<WriterAll>();
      dummySearchList.forEach((item) {
        if (item.writerName.contains(query) ||
            item.writerIntro.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        tapList.clear();
        tapList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        tapList.clear();
        tapList.addAll(duplicateItems);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDailyList();
    print('open list screen initState');
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
                isAllList = true;
                tapList.clear();
                tapList.addAll(duplicateItems);
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
        title: Text('공개노트'),
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
        child: Column(
          children: <Widget>[
            isSearchMode
                ? Row()
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAllList = true;
                      tapList.clear();
                      tapList.addAll(writerAllList);
                    });
                  },
                  child: Text(
                    '작가 목록',
                    style: TextStyle(
                        fontSize: 16,
                        color: isAllList ? Colors.black : Colors.grey,
                        fontWeight: isAllList
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration:
                        isAllList ? TextDecoration.underline : null,
                        decorationColor: Mnote.orange),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAllList = false;
                      tapList.clear();
                      tapList.addAll(writerSubList);
                    });
                  },
                  child: Text(
                    '구독중',
                    style: TextStyle(
                        fontSize: 16,
                        color: !isAllList ? Colors.black : Colors.grey,
                        fontWeight: !isAllList
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration:
                        !isAllList ? TextDecoration.underline : null,
                        decorationColor: Mnote.orange),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                //shrinkWrap: true,
                controller: _scrollController,
                itemCount: tapList.length,
                itemBuilder: (context, index) {
                  if (index >= tapList.length -1){
                     if (isAllList){
                       _initNewList();
                     }else{
                       _initSubList();
                     }
                  }
                  return _writer(index, tapList);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FlatButton(
          onPressed: () => {
            _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut)
          },
          child: Image.asset(
            'images/icons/00_btn_top.png',
            scale: 1.6,
          )),
    );
  }

  Widget _writer(int index, List<WriterAll> list) {
    return GestureDetector(
        onTap: () => _writerListItemClick(list[index].writerEmail),
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
                    list[index].writerName,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Image.asset(
                      list[index].subscribeYN == '0'
                          ? 'images/icons/09_btn_sub.png'
                          : 'images/icons/09_btn_sub02.png',
                      scale: 1.8,
                    ),
                  )
                ],
              ),
              Text(
                list[index].writerIntro,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Mnote.gray153,
                  height: 1.2,
                ),
                textAlign: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' ${list[index].bookCount}개 | ${list[index].subscribeCount}명 구독중',
                    style: Mnote.textHint_13_5,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

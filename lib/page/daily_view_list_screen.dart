import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/model/daily_writings.dart';
import 'package:mnote_app/page/daily_edit_screen.dart';
import 'package:mnote_app/page/daily_list_screen.dart';
import 'package:mnote_app/page/daily_view_screen.dart';
import 'package:mnote_app/service/daily_today_service.dart';
import 'package:mnote_app/service/daily_writings_service.dart';
import 'package:mnote_app/utils/mnote.dart';

class DailyViewListScreen extends StatefulWidget {
  final String dailyListNo; // 빈값일 경우 오늘꺼 하루글감 모드

  DailyViewListScreen({this.dailyListNo=''});

  @override
  _DailyViewListScreenState createState() => new _DailyViewListScreenState();
}

class _DailyViewListScreenState extends State<DailyViewListScreen> {
  int pageNo = 1;
  List<DailyWritings> dailyList = [];

  // 리스트 조회 (초기화)
  void _initDailyList() async{
    //List<DailyWritings> newDailyList = await getDailyTodayWritings(pageNo.toString());
    List<DailyWritings> newDailyList = widget.dailyListNo == ''
        ? await getDailyTodayWritings(pageNo.toString())
        : await getDailyWritings(widget.dailyListNo, pageNo.toString());
    if (newDailyList.length != 0){
      setState(() {
        dailyList.addAll(newDailyList);
      });
      pageNo++;
    }
  }

  // 글쓰기 버튼 클릭
  void _editBtnClick() async{
    DailyModel dailyModel = await getDailyToday();
    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyEditScreen(dailyModel: dailyModel,)));
  }

  // 리스트 아이템 클릭
  void _dailyItemClick(int index){
    print('????');
    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyViewScreen(dailyWritings: dailyList[index],)));
  }

  // 글감모음 버튼 클릭
  void _dailyWritingsBtnClick(){

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('??? - daily_view_list_screen');
    _initDailyList();
  }

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
            onPressed: ()=>_editBtnClick(),
          )
        ],
      ),
      backgroundColor: Mnote.gray245,
      body: Container(
          decoration: dailyList.length > 0 ? null : BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('images/icons/11_empty.png'),
                  fit: BoxFit.none
              )),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 14),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(dailyList.length > 0 ? dailyList[0].dailyDate : '', style: TextStyle(color: Mnote.gray153),),
                  GestureDetector(
                    onTap: () {
                      print(ModalRoute.of(context).settings.name);
                      if(ModalRoute.of(context).settings.name == '/main/daily_view_list'){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DailyListScreen()));
                      }else{
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset('images/icons/11_btn_wording.png', scale: 1.6,),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: dailyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= dailyList.length -1) {
                        _initDailyList();
                      }
                      return _note(index, dailyList);
                    }),
              )
            ],
          )
      ),
      floatingActionButton: FlatButton(onPressed: ()=>{}, child: Image.asset('images/icons/00_btn_top.png', scale: 1.6,)),
    );
  }

  Widget _note(int index, List<DailyWritings> noteList) {
    return GestureDetector(
        onTap: () => _dailyItemClick(index),
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
                child: Text(noteList[index].chapterTitle, style: Mnote.textBlack_20,),),
              Expanded(
                flex: 5,
                child: Text(
                  noteList[index].contents,
                  style: TextStyle(color: Mnote.gray153, fontSize: 16, height: 1.5,),
                  textAlign: TextAlign.center,),
              ),
              Expanded(
                child: Text(noteList[index].writerName, style: TextStyle(decoration: TextDecoration.underline, ),),
              )
            ],
          ),

        )
    );
  }
}

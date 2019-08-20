import 'package:flutter/material.dart';
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/model/daily_writings.dart';
import 'package:mnote_app/page/daily_edit_screen.dart';
import 'package:mnote_app/page/open_note_book_list_screen.dart';
import 'package:mnote_app/service/daily_today_service.dart';
import 'package:mnote_app/service/writer_service.dart';
import 'package:mnote_app/utils/mnote.dart';

class DailyViewScreen extends StatefulWidget {
  final DailyWritings dailyWritings;
  DailyViewScreen({this.dailyWritings});

  @override
  _DailyViewScreenState createState() => _DailyViewScreenState();
}

class _DailyViewScreenState extends State<DailyViewScreen> {

  // 글쓰기 버튼 클릭
  void _editBtnClick() async{
    DailyModel dailyModel = await getDailyToday();
    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyEditScreen(dailyModel: dailyModel,)));
  }

  void _boxTopRightMenuBtnClick(String mode) async{
    if (mode == '구독하기'){
      await updateSubState(widget.dailyWritings.email, '1');
      return;
    }

    if (mode == '노트보기'){
      Navigator.push(context,MaterialPageRoute(builder: (context) => OpenNoteBookListScreen(email: widget.dailyWritings.email,)));
      return;
    }

    if (mode == '신고하기'){
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            child: Text('글작성',
              style: Mnote.appBarRightOkBtnText,
            ),
            onPressed: () => _editBtnClick(),
          ),
          SizedBox(width: 20,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(38),
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.dailyWritings.writerName, style: TextStyle(decoration: TextDecoration.underline, ),),
                    DropdownButton<String>(
                      items: <String>['구독하기', '노트보기', '신고하기'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: GestureDetector(
                            onTap: ()=>_boxTopRightMenuBtnClick(value),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      icon: Image.asset('images/icons/00_text_component_01.png',scale: 1.2,),
                      underline: DropdownButtonHideUnderline(child: Row(),),
                      onChanged: (_) {
                        print(_);
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20,),
                Text(widget.dailyWritings.chapterTitle, style: Mnote.textBlack_20,),
                SizedBox(height: MediaQuery.of(context).size.height / 35,),
                Text(widget.dailyWritings.contents,
                  style: TextStyle(color: Mnote.gray153, fontSize: 16, height: 1.5,),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 35,),
                Text(Mnote.getDateFormat_1(widget.dailyWritings.dailyDate), style: Mnote.textHint_13_5,),
              ],
            ),

          ),
        ),
      ),
    );
  }
}

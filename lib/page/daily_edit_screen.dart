import 'package:flutter/material.dart';
import 'package:mnote_app/dialog/common_back_dialog.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'note_edit_screen.dart';

typedef void ContentDoubleTabHandler(bool visibility);

/*
 * 하루글감 작성 화면
 * 메인 > 하루글감 > 하루글감 글쓰기 버튼 클릭시 보이는 화면
 *
 */

class DailyEditScreen extends StatefulWidget {
  final DailyModel dailyModel;

  DailyEditScreen({
    this.dailyModel,
  });

  @override
  _DailyEditScreenState createState() => _DailyEditScreenState();
}

class _DailyEditScreenState extends State<DailyEditScreen> {
  bool visibilityEditFinishBtn = true; // 노트 화면 > 작성완료 버튼
  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();

  FocusNode titleFocusNode = FocusNode(); // 제목 포커스 노드
  FocusNode contentsFocusNode = FocusNode(); // 내용 포커스 노드

  // 정말로 뒤로 가시겠습니까? 다이얼로그
  void _showCommonBackDialog() {
    if (visibilityEditFinishBtn){
      showDialog(
        context: context,
        builder: (_) => CommonBackDialog(),
      );
    }
  }

  void _contentFieldFocusListener() {
    print('_contentFieldFocusListener');
    print("Has focus: ${contentsFocusNode.hasFocus}");
    setState(() {
      visibilityEditFinishBtn = !contentsFocusNode.hasFocus;
    });
  }

  void _titleFieldFocusListener(){
    print('_titleFieldFocusListener');
    print("Has focus: ${titleFocusNode.hasFocus}");
    setState(() {
      visibilityEditFinishBtn = !titleFocusNode.hasFocus;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    titleFocusNode.addListener(_titleFieldFocusListener);
    contentsFocusNode.addListener(_contentFieldFocusListener);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleFocusNode.dispose();
    contentsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){
        _showCommonBackDialog();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: FlatButton(
                padding: EdgeInsets.only(left: 30),
                onPressed: () => _showCommonBackDialog(),
                child: Image.asset('images/icons/00_chapter_pre.png')),
            backgroundColor: Colors.black,
            title: Text(widget.dailyModel.dailyTitle),
            centerTitle: true,
            actions: <Widget>[
              visibilityEditFinishBtn
                  ? Row()
                  : FlatButton(
                padding: EdgeInsets.only(right: 30),
                child: Text('작성완료', style: Mnote.appBarRightOkBtnText),
                onPressed: () {
                  Navigator.pop(context);
                  MyNavigator.goToDailySubject(context);
                },
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: NoteEditScreen(
            chapterModel: ChapterModel(
                chapterTitle: widget.dailyModel.dailyTitle,
                contents: '',
                contentsAlignCenter: '0',
                chapterStartDate: DateTime.now().toString()),
            mode: 'daily',
            titleController: titleController,
            contentsController: contentsController,
            titleFocusNode: titleFocusNode,
            contentsFocusNode: contentsFocusNode,
          )),);
  }
}

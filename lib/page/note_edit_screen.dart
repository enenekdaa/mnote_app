import 'package:flutter/material.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/widget/monote_line.dart';

typedef void ContentDoubleTabHandler(bool visibility);

class NoteEditScreen extends StatefulWidget{
  final ChapterModel chapterModel;
  final mode; // my = 일반 글쓰기 / daily = 하루 글감
  ContentDoubleTabHandler contentDoubleTabCallback;

  NoteEditScreen({
    this.chapterModel,
    this.mode = 'my',
    this.contentDoubleTabCallback
  });

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();

}

class _NoteEditScreenState extends State<NoteEditScreen> {
  ChapterModel chapterModel;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();
  final FocusNode _contentFieldFocusNode = FocusNode();

  bool visibilityEditor = false; // 내용입력 에디터 폼 보이기 on/off
  bool visibilityTime = true; // 노트 화면 > 시간 보이기 on/off
  bool visibilityOpenNote = false; // 공개노트설정버튼 보이기 on/off


  void _initChapterDetail() async{
    setState(() {
      chapterModel = widget.chapterModel;
      titleController.text = chapterModel.chapterTitle;
      contentsController.text = chapterModel.contents;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentFieldFocusNode.addListener(_contentFieldFocusListener);

    chapterModel = ChapterModel(
        chapterTitle: ' ',
        contents: ' ',
        contentsAlignCenter: '0',
        chapterStartDate: DateTime.now().toString()
    );

    if (widget.chapterModel != null){
      _initChapterDetail();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contentFieldFocusNode.dispose();
    super.dispose();
  }


  void _contentFieldFocusListener() {
    print('1');
    print("Has focus: ${_contentFieldFocusNode.hasFocus}");
    setState(() {
      visibilityEditor = _contentFieldFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    visibilityOpenNote = ModalRoute.of(context).settings.name == '/daily_edit';

    // TODO: implement build
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        // 제목 + 내용
        Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              // 제목 입력 폼
              Container(
                padding: EdgeInsets.only(left: 8, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 제목 입력 영역
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (text) {
                              List<String> textList = text.split('\n');
                              if (textList.length > 2) {
                                textList.removeAt(2);
                                  titleController.text = textList.join('\n');
                              }
                            },
                            controller: titleController,
                            style: Mnote.noteTitleFiledHint,
                            decoration: InputDecoration(
                                hintText: '제목을 입력해주세요.',
                                hintStyle: Mnote.noteTitleFiledHint,
                                border: InputBorder.none),
                            enabled: widget.mode != 'daily',
                          ),
                        ),
                        visibilityOpenNote
                            ? SizedBox(
                                child: Image.asset('images/icons/00_toggle_02_on.png', scale: 1.8,),
                              )
                            : SizedBox(width: 1,)
                      ],
                    ),
                    // 날짜 영역
                    visibilityTime
                        ? Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(Mnote.getDateFormat_2(chapterModel.chapterStartDate), style: Mnote.noteSubTitleFiledHint,),
                    )
                        : Container(),
                    // 주황색 선
                    OrangeLine(),
                  ],
                ),
              ),
              // 내용 입력 폼
              Expanded(
                child: GestureDetector(
                  onDoubleTap: (){
                    // 날짜 숨김 처리
                    setState(() {
                      visibilityTime = !visibilityTime;
                    });
                    widget.contentDoubleTabCallback(visibilityTime);
                  },
                  child: TextField(
                    maxLines: 100,
                    onTap: () => {print('작업시작 ')},
                    focusNode: _contentFieldFocusNode,
                    controller: contentsController,
                    decoration: InputDecoration(
                        hintText: '내용을 입력해주세요.',
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintStyle: TextStyle(height: 1.5, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 키보드 에디터 바
        visibilityEditor
            ? Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(child: Image.asset('images/icons/00_text_component_01.png', scale: 1.8,),),
              GestureDetector(child: Image.asset('images/icons/00_text_component_02.png', scale: 1.8),),
              GestureDetector(child: Image.asset('images/icons/00_text_component_03.png', scale: 1.8),),
              GestureDetector(child: Image.asset('images/icons/00_text_component_04.png', scale: 1.8),),
              Container(height: 20,width: 0.3,color: Colors.grey,),
              GestureDetector(child: Image.asset('images/icons/00_text_component_07.png', scale: 1.8),),
              GestureDetector(child: Image.asset('images/icons/00_text_component_09.png', scale: 1.8),),
              GestureDetector(child: Image.asset('images/icons/00_text_component_08.png', scale: 1.8),),
              Container(height: 20,width: 0.3,color: Colors.grey,),
              GestureDetector(child: Image.asset('images/icons/00_text_component_05.png', scale: 1.8),),
              GestureDetector(child: Image.asset('images/icons/00_text_component_06.png', scale: 1.8),),
            ],
          ),
        )
            : Row()
      ],
    );
  }
}
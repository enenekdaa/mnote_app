import 'package:flutter/material.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:mnote_app/widget/monote_line.dart';

typedef void ContentDoubleTabHandler(bool visibility);

/*
 * 노트 에디터 위젯
 * 기본 글쓰기, 하루글감 글쓰기, 공개노트 글쓰기 등 에디터 화면이다.
 * 스택으로 구성되어있으며 타이틀 아래 위치한 화면이다.
 *
 */

class NoteEditScreen extends StatefulWidget{
  final ChapterModel chapterModel;
  final mode; // my = 일반 글쓰기 / daily = 하루 글감
  final TextEditingController titleController;
  final TextEditingController contentsController;
  final FocusNode titleFocusNode;
  final FocusNode contentsFocusNode;
  String textAlignmentValue;

  NoteEditScreen({
    this.chapterModel,
    this.mode = 'my',
    this.titleController,
    this.contentsController,
    this.titleFocusNode,
    this.contentsFocusNode,
    this.textAlignmentValue = '0'
  });

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();

}

class _NoteEditScreenState extends State<NoteEditScreen> {
  ChapterModel chapterModel;

  bool visibilityEditor = false; // 내용입력 에디터 폼 보이기 on/off
  bool visibilityOpenNote = false; // 공개노트설정버튼 보이기 on/off


  void _initChapterDetail() async{
    setState(() {
      chapterModel = widget.chapterModel;
      widget.titleController.text = chapterModel.chapterTitle;
      widget.contentsController.text = chapterModel.contents;
    });
  }

  void _addText(String addText){
    var cursorPos = widget.contentsController.selection;
    String resultText = Mnote.subStringAndAddText(widget.contentsController.text, addText, cursorPos.baseOffset);
    int offset = cursorPos.baseOffset + addText.length;
    widget.contentsController.text = resultText;
    if (addText == '‘’' || addText == '“”'){
      offset = offset - 1;
    }
    cursorPos = TextSelection.fromPosition(TextPosition(offset: offset));
    widget.contentsController.selection = cursorPos;
  }

  void _cursorPosTopOrBot(String move){
    var cursorPos = widget.contentsController.selection;
    int offset = move == 'top' ? 0 : widget.contentsController.text.length;
    cursorPos = TextSelection.fromPosition(TextPosition(offset: offset));
    widget.contentsController.selection = cursorPos;
  }

  void _changeTextAlignmentValue(String align){
    Mnote.alignValue = align;

    String origin =  widget.contentsController.text;
    String temp = origin + ' ';
    // widget.contentsController.clear();

    var cursorPos = widget.contentsController.selection;
    int offset = origin.length;
    cursorPos = TextSelection.fromPosition(TextPosition(offset: offset));

    setState(() {
      widget.textAlignmentValue = align;
      widget.contentsController.text = temp;
      widget.contentsController.selection = cursorPos;
    });

    if(widget.contentsFocusNode.hasFocus){
      // widget.contentsFocusNode.unfocus();
    }else{
      FocusScope.of(context).requestFocus(widget.contentsFocusNode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chapterModel = ChapterModel(
        chapterTitle: ' ',
        contents: ' ',
        contentsAlignCenter: '0',
        chapterStartDate: DateTime.now().toString()
    );

    if (widget.chapterModel != null){
      _initChapterDetail();
    }

    Mnote.alignValue = chapterModel.contentsAlignCenter;
  }

  @override
  void didUpdateWidget(NoteEditScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('note_edit_screen didUpdateWidget');
    visibilityEditor = widget.contentsFocusNode.hasFocus;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('note_edit_screen dispose');
    super.dispose();
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
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              // 제목 입력 폼
              Container(
                padding: EdgeInsets.only(left: 14, top: 12),
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
                            focusNode: widget.titleFocusNode,
                            onChanged: (text) {
                              List<String> textList = text.split('\n');
                              if (textList.length > 2) {
                                textList.removeAt(2);
                                widget.titleController.text = textList.join('\n');
                              }
                            },
                            controller: widget.titleController,
                            style: TextStyle(
                                fontSize: 24, color: Mnote.nightModeTextColor
                            ),
                            decoration: InputDecoration(
                                hintText: '제목을 입력해주세요.',
                                hintStyle: TextStyle(
                                  fontSize: 24,
                                  color: Mnote.nightModeTextColor
                                ),
                                border: InputBorder.none,
                            ),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(Mnote.getDateFormat_2(chapterModel.chapterStartDate), style: Mnote.noteSubTitleFiledHint,),
                    ),
                    // 주황색 선
                    OrangeLine(),
                  ],
                ),
              ),
              // 내용 입력 폼
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: ()=>{},
                  child: TextField(
                    maxLines: 100,
                    onTap: () => {print('작업시작 ')},
                    textAlign: widget.textAlignmentValue == '0'
                        ? TextAlign.left
                        : widget.textAlignmentValue == '1'
                        ? TextAlign.center
                        : TextAlign.right,
                    focusNode: widget.contentsFocusNode,
                    controller: widget.contentsController,
                    style: TextStyle(height: 1.5, fontSize: 16, color: Mnote.nightModeTextColor,),
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요.',
                      filled: true,
                      fillColor: Mnote.nightModeBackgroundColor,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Mnote.nightModeTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: visibilityEditor ? 30 : 1,)
            ],
          ),
        ),
        SizedBox(height: 30,),
        // 키보드 에디터 바
        visibilityEditor
            ? Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.3))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // ...
              GestureDetector(
                onTap: ()=>_addText('…'),
                child: Image.asset('images/icons/00_text_component_01.png', scale: 1.8,),
              ),
              GestureDetector(
                onTap: ()=>_addText('‘’'),
                child: Image.asset('images/icons/00_text_component_02.png', scale: 1.8),
              ),
              GestureDetector(
                onTap: ()=>_addText('“”'),
                child: Image.asset('images/icons/00_text_component_03.png', scale: 1.8),
              ),
              GestureDetector(
                onTap: ()=>_addText('·'),
                child: Image.asset('images/icons/00_text_component_04.png', scale: 1.8),
              ),
              Container(height: 20,width: 0.3,color: Colors.grey,),
              GestureDetector(
                onTap: (){
                  _changeTextAlignmentValue('0');
                },
                child: Image.asset('images/icons/00_text_component_07.png', scale: 1.8),
              ),
              GestureDetector(
                onTap: (){
                  _changeTextAlignmentValue('1');
                },
                child: Image.asset('images/icons/00_text_component_09.png', scale: 1.8),
              ),
              GestureDetector(
                onTap: (){
                  _changeTextAlignmentValue('2');
                },
                child: Image.asset('images/icons/00_text_component_08.png', scale: 1.8),
              ),
              Container(height: 20,width: 0.3,color: Colors.grey,),
              GestureDetector(
                onTap: () => _cursorPosTopOrBot('top'),
                child: Image.asset('images/icons/00_text_component_05.png', scale: 1.8),
              ),
              GestureDetector(
                onTap: () => _cursorPosTopOrBot('bot'),
                child: Image.asset('images/icons/00_text_component_06.png', scale: 1.8),
              ),
            ],
          ),
        )
            : Row()
      ],
    );
  }
}
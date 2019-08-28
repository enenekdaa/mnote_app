import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/dialog/note_save_dialog.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/service/purchase_service.dart';
import 'package:mnote_app/service/user_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_screen.dart';
import 'note_edit_screen.dart';
import 'note_book_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool visibilityEditFinishBtn = false; // true=보임/false=안보임 노트 화면 > 작성완료 버튼
  int currentPageIndex = 0; // 현재 화면 페이지
  int noteListPageIndex = 1; // 노트리트 페이지 번호

  TextEditingController titleController = TextEditingController(); // 제목 컨트롤러
  TextEditingController contentsController = TextEditingController(); // 본문 컨트롤러
  FocusNode titleFocusNode = FocusNode(); // 제목 포커스 노드
  FocusNode contentsFocusNode = FocusNode(); // 내용 포커스 노드

  SharedPreferences _prefs;

  // 푸시
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  void _onPageChanged(int index){
    setState(() {
      currentPageIndex = index;
      titleFocusNode.unfocus();
      contentsFocusNode.unfocus();
    });
  }


  void _contentFieldFocusListener() {
    print('_contentFieldFocusListener');
    print("Has focus: ${contentsFocusNode.hasFocus}");
    setState(() {
      visibilityEditFinishBtn = contentsFocusNode.hasFocus == true || titleFocusNode.hasFocus == true; // 둘중 하나라도 포커싱 생기면 '작성완료'버튼 보임
    });
  }

  void _titleFieldFocusListener(){
    print('_titleFieldFocusListener');
    print("Has focus: ${titleFocusNode.hasFocus}");
    setState(() {
      visibilityEditFinishBtn = contentsFocusNode.hasFocus == true || titleFocusNode.hasFocus == true; // 둘중 하나라도 포커싱 생기면 '작성완료'버튼 보임
    });
  }

  void _editFinishBtnClick(){
    if (titleController.text.trim().replaceAll(' ', '') == ''){
      Fluttertoast.showToast(msg: '제목을 입력해주세요. ');
      return;
    }

    showDialog(
      context: context,
      builder: (_) => NoteSaveDialog(titleController.text, contentsController.text),
    ).then((result){
      print('home_screen');
      if(result != null && result != '실패'){
        Navigator.pushReplacementNamed(context, '/home');
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteBookViewScreen(bookNo: result)));
      }
    });
  }


  void _initSharedPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  void _initInApp() async {
    Mnote.isInApp = await getHistoryInApp();
  }

  @override
  void initState() {
    // TODO: implement initState
    titleFocusNode.addListener(_titleFieldFocusListener);
    contentsFocusNode.addListener(_contentFieldFocusListener);
    noteListPageIndex = Mnote.homeEditMode == 'ON' ? 1 : 0; // 첫화면 글쓰기일 경우 1페이지가 노트리스트페이지 Index

    // 인앱 셋팅
    setInitSubscription();
    _initInApp();

    // 프리퍼런스 셋팅
    _initSharedPreferences();

    // push
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
        print('iosSubscription ----------------');
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    print('FCM TOKEN !! ---------');
    print(_fcm.getToken().then((result){
      // TODO:: 토큰 서버 저장 작업
      print(result);
    }));
    print('');

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
// TODO:: 앱 켰을때 받은 메시지 보여주고 싶을때
//        showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//            content: ListTile(
//              title: Text(message['notification']['title']),
//              subtitle: Text(message['notification']['body']),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Ok'),
//                onPressed: () => Navigator.of(context).pop(),
//              ),
//            ],
//          ),
//        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );


    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleFocusNode.dispose();
    contentsFocusNode.dispose();
    disposeSubscription();
    super.dispose();
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('home screen didUpdateWidget');
    _prefs.setString('access_token', Mnote.accessToken);
    _prefs.setString('refresh_token', Mnote.refreshToken);
    if ((_prefs.getString('is_in_app') == 'Y') != Mnote.isInApp){
      // 프리퍼런스 값과 틀릴때만 저장한다.
      updateSubscribeYN(context, Mnote.isInApp ? 'Y' : 'N');
      _prefs.setString('is_in_app', Mnote.isInApp ? 'Y' : 'N');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mnote.nightMode == 'OFF'
          ? Colors.white
          : Mnote.nightModeBackgroundColor,
          //: Mnote.homeEditMode == 'ON' && currentPageIndex == 0
          //? Mnote.mnoteEditBackgroundColor
          //: Mnote.homeEditMode == 'OFF' && currentPageIndex == 1
          //? Mnote.mnoteEditBackgroundColor
          //: Colors.white,
      drawer: NavigationScreen(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:
        Builder(
          builder: (context) => FlatButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Image.asset('images/icons/00_top_menu.png')),
        ),
        title: Text('무제노트',),
        actions: <Widget>[
          // 작성완료 버튼 보임/숨김 처리
          visibilityEditFinishBtn == false
              ? FlatButton(child: Text(''),onPressed: () => null,)
              : FlatButton(
                  child: Text('작성완료', style: Mnote.appBarRightOkBtnText),
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () => _editFinishBtnClick(),
                )
        ],
      ),
      body: PageView(
        onPageChanged: (index) => _onPageChanged(index),
        children: <Widget>[
          // 첫화면 글쓰기가 ON일 경우 첫번째 페이지를 글쓰기 화면으로 설정
          Mnote.homeEditMode == 'ON'
              ? NoteEditScreen(
                  titleController: titleController,
                  contentsController: contentsController,
                  titleFocusNode: titleFocusNode,
                  contentsFocusNode: contentsFocusNode,
                )
              : NoteBookListScreen(),
          Mnote.homeEditMode == 'ON'
              ?  NoteBookListScreen()
              : NoteEditScreen(
                  titleController: titleController,
                  contentsController: contentsController,
                  titleFocusNode: titleFocusNode,
                  contentsFocusNode: contentsFocusNode,
                  ),
        ],
      ),
    );
  }
}


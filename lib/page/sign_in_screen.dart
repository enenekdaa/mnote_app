import 'package:flutter/material.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'package:mnote_app/model/Book_other.dart';
import 'package:mnote_app/model/Book_other_intro.dart';
import 'package:mnote_app/model/Book_writings.dart';
import 'package:mnote_app/model/Daily_model.dart';
import 'package:mnote_app/model/Login.dart';
import 'package:mnote_app/model/Writer_all.dart';
import 'package:mnote_app/service/book_other_detail_service.dart';
import 'package:mnote_app/service/book_other_intro_service.dart';
import 'package:mnote_app/service/book_other_service.dart';
import 'package:mnote_app/service/book_other_writings.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/service/books_my_service.dart';
import 'package:mnote_app/service/books_today_service.dart';
import 'package:mnote_app/service/books_writings_service.dart';
import 'package:mnote_app/service/daily_list_service.dart';
import 'package:mnote_app/service/daily_writings_service.dart';
import 'package:mnote_app/service/writer_all_service.dart';
import 'package:mnote_app/utils/m_navigator.dart';
import 'package:mnote_app/model/Book_info.dart';
import 'package:mnote_app/model/Book_detail.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => new _SignInScreen();
}



class _SignInScreen extends State<SignInScreen> {
  bool _value1 = true;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  List<Login> list = [];
  List<Book_detail> detailList = [];
  List<Book_writings> writingList = [];
  List<Daily_model> dailyList = [];
  List<Daily_model> dailyWritingsList = [];
  List<Writer_all> writerAllList = [];
  List<Book_other> bookOtherList = [];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                'images/icons/00_main_logo.png',
                scale: 1.8,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.2, color: Colors.black38)),
                        hintText: 'example@example.com',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.2, color: Colors.black38)),
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () => {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: _value1,
                            onChanged: _value1Changed,
                            checkColor: Colors.white,
                            activeColor: Colors.black,
                          ),
                          Text('자동 로그인')
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        MyNavigator.goToHome(context);
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15),
                      color: Colors.black,
                      child: Text(
                        '로그인',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => {},
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text('PW찾기'),
                            Image.asset('images/icons/00_login_arrow.png', scale: 1.8,)
                          ],
                        ),
                      ),
                      Text('|', style: TextStyle(color: Colors.black12),),
                      FlatButton(
                        onPressed: () => MyNavigator.goToSignUp(context),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text('회원가입'),
                            Image.asset('images/icons/00_login_arrow.png', scale: 1.8,)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
                  
                                  // 책 몰록 사용자 정보 ...
//                onPressed: ()=> getBookInfoItem('http://icomerict.cafe24.com/untitled_note/json/books_my_book_detail.php').then((bookInfo) {
//                  print('로 그  : : : : : ' + bookInfo.book_title);
//                }),
              // 책 목록 리스트 < chapter_no ... 등등
//                onPressed: ()=> getBookDetailItems('http://icomerict.cafe24.com/untitled_note/json/books_my_book_detail.php').then((detailList) {
//                  print('로 그  : : : : : ' + detailList.elementAt(0).chapter_title);
//                }),
              // 로그인 result ..
//              onPressed: ()=> getloginResult('http://icomerict.cafe24.com/untitled_note/json/books_my.php').then((list) {
//                print('로 그  : : : : : ' + list.elementAt(0).book_title);
//              }),

                /*
              *  챕터 .. 얘네둘도  url 이랑 파람 하나만 다름
              *   http://icomerict.cafe24.com/untitled_note/json/books_chapter_detail.php = 얘는 chapter_no / book_no
              *      http://icomerict.cafe24.com/untitled_note/json/books_other_chapter_detail.php 얘는 chapter_no / book_no / + email
              *
              *   모델 같음
              *   json 리스트 끄내올때 키값도 같음
              *   service 호출할때 파라미터 고정시켜놓고 email == null 은 books : email != null 은 other ... 이런식으로하면됨 ㅇㅇ
              * */
//              onPressed: () => getChapterDetail('http://icomerict.cafe24.com/untitled_note/json/books_chapter_detail.php').then((chapterDetail) {
//                print('로 그  : : : : : ' + chapterDetail.contents);
//              }),
//                onPressed: () => getChapterDetail('http://icomerict.cafe24.com/untitled_note/json/books_other_chapter_detail.php').then((chapterDetail) {
//                  print('로 그  : : : : : ' + chapterDetail.chapter_title);
//                }),


//              onPressed: () => getBooksToday('http://icomerict.cafe24.com/untitled_note/json/daily_today.php').then((booksToday) {
//                print('로 그  : : : : : ' + booksToday.daily_sentence);
//              }),

//                onPressed: () => getBooksWritings('http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php').then((writingList) {
//                  print('로 그  : : : : : ' + writingList.elementAt(0).chapter_title);
//                }),

//                onPressed: () => getBooksWritings('http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php').then((writingList) {
//                  print('로 그  : : : : : ' + writingList.elementAt(0).chapter_title);
//                }),
//                onPressed: () => getDailyList('http://icomerict.cafe24.com/untitled_note/json/daily_list.php').then((dailyList) {
//                  print('로 그  : : : : : ' + dailyList.elementAt(0).daily_sentence);
//                }),

              /*
              *  글감 모아보기 ..
              *   http://icomerict.cafe24.com/untitled_note/json/daily_writings.php   랑   http://icomerict.cafe24.com/untitled_note/json/daily_writings.php 얘랑 둘다 모델값 같고
              *   결과값이 같아서 걍 꺼내쓰는것만 다름 ... url만 바꾸면됨 ㅇㅇ
              * */
//                onPressed: () => getDailyWritingsList('http://icomerict.cafe24.com/untitled_note/json/daily_writings.php').then((dailyWritingsList) {
//                  print('로 그  : : : : : ' + dailyWritingsList.elementAt(0).contents);
//                }),
//
//                onPressed: () => getWriterAllList('http://icomerict.cafe24.com/untitled_note/json/writer_list_all.php').then((writerAllList) {
//                  print('로 그  : : : : : ' + writerAllList.elementAt(0).writer_name);
//                }),

                /*
              *  구독목록 ..
              *   http://icomerict.cafe24.com/untitled_note/json/writer_list_all.php   랑   http://icomerict.cafe24.com/untitled_note/json/writer_list_sub.php 얘랑 둘다 모델값 같고
              *   결과값이 같아서 걍 꺼내쓰는것만 다른데
              *   json 리스트 끄내올때 키값이 다름 ['writer_list']   /////   ['my_sub_list']
              *   service 호출할때 매개변수로 플래그값 넘겨주면서 호출하면될듯 . .? ex) getWriterAllList( url , flag ).then...... 이런식
              * */
//                onPressed: () => getWriterAllList('http://icomerict.cafe24.com/untitled_note/json/writer_list_all.php').then((writerAllList) {
//                  print('로 그  : : : : : ' + writerAllList.elementAt(0).writer_name);
//                }),

                /*
              *  작가목록 클릭시 ..
              *  작가필명이 파라미터래 ex) writerAllList.elementAt(i).witer_name <<< 얘가 파라미터임 ㅇㅇ
              * */
//                onPressed: () => getBookOtherList('http://icomerict.cafe24.com/untitled_note/json/books_other.php').then((bookOtherList) {
//                  print('로 그  : : : : : ' + bookOtherList.elementAt(0).book_cover_img_no);
//                }),
                /*
              *  노트 클릭시 ..
              *  작가필명이 파라미터래 ex) writerAllList.elementAt(i).witer_name <<< 얘가 파라미터임 ㅇㅇ
              *  writerAllList.elementAt(i).book_no << 얘도
              * */
//                onPressed: () => getBookOtherIntroList('http://icomerict.cafe24.com/untitled_note/json/books_other_intro.php').then((BookOtherIntro) {
//                  print('로 그  : : : : : ' + BookOtherIntro.book_intro);
//                }),

                /*
              *  공개노트 자세히 ..
              *  얘네 둘도 한세트임 ...  info / detail
              *  param = { email , book_no }
              * */
//                onPressed: () => getBookOtherInfoItem('http://icomerict.cafe24.com/untitled_note/json/books_other_book_detail.php').then((BookOtherInfo) {
//                  print('로 그  : : : : : ' + BookOtherInfo.book_subtitle);
//                }),
//                onPressed: () => getBookOtherDetailItems('http://icomerict.cafe24.com/untitled_note/json/books_other_book_detail.php').then((detailList) {
//                  print('로 그  : : : : : ' + detailList.elementAt(0).chapter_title);
//                }),

                /*
              *  하루글감 공개노트 ..
              *  얘네 둘도 한세트임 ...  info / detail
              *  param = { email}
              * */
//                onPressed: () => getBookOtherWritings('http://icomerict.cafe24.com/untitled_note/json/daily_other_writings.php').then((BookOtherWritings) {
//                  print('로 그  : : : : : ' + BookOtherWritings.book_subtitle);
//                }),

//                onPressed: () => getBookOtherWritingsDetail('http://icomerict.cafe24.com/untitled_note/json/daily_other_writings.php').then((detailList) {
//                  print('로 그  : : : : : ' + detailList.elementAt(0).chapter_title);
//                }),
                    //  onPressed: () => MyNavigator.goToHome(context),

import 'package:flutter/material.dart';
import 'package:mnote_app/model/Book_writings.dart';
import 'package:mnote_app/model/Login.dart';
import 'package:mnote_app/service/books_chapter_service.dart';
import 'package:mnote_app/service/books_detail_service.dart';
import 'package:mnote_app/service/books_my_service.dart';
import 'package:mnote_app/service/books_today_service.dart';
import 'package:mnote_app/service/books_writings_service.dart';
import 'package:mnote_app/utils/m_navigator.dart';
import 'package:mnote_app/model/Book_info.dart';
import 'package:mnote_app/model/Book_detail.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => new _SignInScreen();
}



class _SignInScreen extends State<SignInScreen> {
  bool _value1 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  List<Login> list = [];
  List<Book_detail> detailList = [];
  List<Book_writings> writingList = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50),
              child: Text(
                "무제 노트",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide:
                      BorderSide(width: 0.2, color: Colors.black38)),
                  hintText: 'email..',
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
                  hintText: 'pass..',
                  hintStyle: TextStyle(color: Colors.black12),
                ),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: _value1,
                      onChanged: _value1Changed,
                      checkColor: Colors.black,
                      activeColor: Colors.purple,
                    ),
                    Text('자동 로그인')
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: MaterialButton(
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

//              onPressed: () => getChapterDetail('http://icomerict.cafe24.com/untitled_note/json/books_chapter_detail.php').then((chapterDetail) {
//                print('로 그  : : : : : ' + chapterDetail.contents);
//              }),

//              onPressed: () => getBooksToday('http://icomerict.cafe24.com/untitled_note/json/daily_today.php').then((booksToday) {
//                print('로 그  : : : : : ' + booksToday.daily_sentence);
//              }),

//                onPressed: () => getBooksWritings('http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php').then((writingList) {
//                  print('로 그  : : : : : ' + writingList.elementAt(0).chapter_title);
//                }),

                onPressed: () => getBooksWritings('http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php').then((writingList) {
                  print('로 그  : : : : : ' + writingList.elementAt(0).chapter_title);
                }),
                    //  onPressed: () => MyNavigator.goToHome(context),
                minWidth: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                      Text('PW찾기')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => MyNavigator.goToSignUp(context),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text('회원가입')
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

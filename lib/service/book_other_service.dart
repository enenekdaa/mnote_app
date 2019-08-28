import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/utils/mnote.dart';
/*
 *  공개노트
 *  해당 작가의 노트 리스트 로드
 */

Future<List<BookModel>> getBookOtherList(BuildContext context, String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email },
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    final items = (jsonResponse['books_other'] as List)
        .map((i) => new BookModel.fromJson(i));
    return items.toList();
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getBookOtherList(context, email);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

/*
 *  공개노트의 인트로 (소개화면)
 *  해당 작가의 노트 리스트에서 노트 클릭시 
 *  노트의 챕터 목록 나오는 화면 
 */
Future<BookModel> getBookOtherIntroList(BuildContext context, String email, String bookNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other_intro.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email , 'book_no' : bookNo},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    BookModel bookOtherIntro = new BookModel.fromJson(jsonResponse['books_other_intro']);
    return bookOtherIntro;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getBookOtherIntroList(context, email, bookNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}



/*
 *  공개노트의 글 (view) 화면 - 노트 정보
 */

Future<BookModel> getBookOtherWritingsDetail(BuildContext context, String email, String bookNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other_book_detail.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'book_no': bookNo, 'email' : email},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    BookModel bookInfo = BookModel.fromJson(jsonResponse['book_info']);
    return bookInfo;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getBookOtherWritingsDetail(context, email, bookNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}


/*
 *  공개노트의 글 (view) 화면 - 노트 챕터 목록
 *
 */
Future<List<ChapterModel>> getBookOtherWritingsDetailList(BuildContext context, String email, String bookNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other_book_detail.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'book_no': bookNo, 'email' : email},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    final items = (jsonResponse['book_detail'] as List).map((i) => new ChapterModel.fromJson(i));
    return items.toList();
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getBookOtherWritingsDetailList(context, email, bookNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}


/*
 *  공개노트의 글 - 챕터 상세 (view) 화면
 *
 */
Future<ChapterModel> getBookOtherChapterDetail(BuildContext context, String email, String bookNo, String chapterNo) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/books_other_chapter_detail.php';

  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {'book_no': bookNo, 'chapter_no': chapterNo, 'email': email},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    ChapterModel chapterDetail =
    new ChapterModel.fromJson(jsonResponse['chapter_detail']);
    return chapterDetail;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getBookOtherChapterDetail(context, email, bookNo, chapterNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}


/*
 *  공개노트의 하루글감 목록 화면
 */

Future<BookModel> getBookOtherWritings(BuildContext context, String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_other_writings.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    BookModel bookOtherWritings = new BookModel.fromJson(jsonResponse['book_info']);
    return bookOtherWritings;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getBookOtherWritings(context, email);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;

}
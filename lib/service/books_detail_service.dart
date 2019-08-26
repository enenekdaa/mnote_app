import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mnote_app/model/book_model.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/utils/mnote.dart';

/*
 챕터 관련
*/

Future<BookModel> getBookInfoItem(BuildContext context, String book_no) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_my_book_detail.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken}, body: {'book_no' : book_no},);

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());
  if (response.statusCode == 200 || isTokenOk) {
    BookModel bookInfo = BookModel.fromJson(jsonResponse['book_info']);
    print(jsonResponse['book_info']);
    return bookInfo;

  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}

Future<List<ChapterModel>> getBookDetailItems(BuildContext context, String bookNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_my_book_detail.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken}, body: {'book_no' : bookNo},);

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    final items = (jsonResponse['book_detail'] as List).map((i) => new ChapterModel.fromJson(i));
    return items.toList();

  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}


Future<BookModel> getDailyInfoItem(BuildContext context) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken});

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    BookModel bookInfo = BookModel.fromJson(jsonResponse['book_info']);
    return bookInfo;

  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }

}

Future<List<ChapterModel>> getDailyDetailItems(BuildContext context) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken});

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    final items = (jsonResponse['book_detail'] as List).map((i) => new ChapterModel.fromJson(i));
    return items.toList();

  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }

}
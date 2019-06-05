import 'dart:convert';
import 'package:mnote_app/model/Book_detail.dart';
import 'package:mnote_app/model/Book_info.dart';
import 'package:mnote_app/model/Login.dart';
import 'package:http/http.dart' as http;

//String dataURL = "http://icomerict.cafe24.com/checkcheck/json/check_result.php?name_0=%EB%82%B4%EC%9D%B4%EB%A6%84&birth_date_0=1991-05-24&birth_hour_0=0&cal_style_0=0&name_1=%EC%83%81%EB%8C%80%EC%9D%B4%EB%A6%84&birth_date_1=1991-05-24&birth_hour_1=13&cal_style_1=0&check_style=1";
String resultURL;
Future<List<Book_detail>> getBookDetailItems(String dataURL) async {
  resultURL = dataURL;
  final response = await http.post(dataURL ,
    headers: {'access_token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NTg5NDIyMjYsIm5iZiI6MTU1ODk0MjIyNiwianRpIjoiYVdOdmJXVnlYM1J2YTJWdVNVUT0iLCJleHAiOjE1OTAwNDYyMjYsImVtYWlsIjoia2RtNzE3M0BnbWFpbC5jb20ifQ.VfuUXV3Tc0e5rMSecrsFrPI64YmROLnIMW6pkns_4OE'},
    body: {'book_no' : '2'},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    final items = (jsonResponse['book_detail'] as List).map((i) => new Book_detail.fromJson(i));

    //print(post.first.dial_00);

    return items.toList();

  } else {
    throw Exception('Failed to load post');
  }

}


Future<Book_info> getBookInfoItem(String dataURL) async {
  resultURL = dataURL;
  final response = await http.post(dataURL ,
    headers: {'access_token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NTg5NDIyMjYsIm5iZiI6MTU1ODk0MjIyNiwianRpIjoiYVdOdmJXVnlYM1J2YTJWdVNVUT0iLCJleHAiOjE1OTAwNDYyMjYsImVtYWlsIjoia2RtNzE3M0BnbWFpbC5jb20ifQ.VfuUXV3Tc0e5rMSecrsFrPI64YmROLnIMW6pkns_4OE'},
    body: {'book_no' : '2'},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    Book_info bookInfo = new Book_info.fromJson(jsonResponse['book_info']);

    //print(post.first.dial_00);

    return bookInfo;

  } else {
    throw Exception('Failed to load post');
  }

}
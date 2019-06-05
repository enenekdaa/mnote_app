import 'dart:convert';
import 'package:mnote_app/model/Book_detail.dart';
import 'package:mnote_app/model/Book_info.dart';
import 'package:mnote_app/model/Book_today.dart';
import 'package:mnote_app/model/Chapter_detail.dart';
import 'package:mnote_app/model/Login.dart';
import 'package:http/http.dart' as http;

String resultURL;
Future<Book_today> getBooksToday(String dataURL) async {
  resultURL = dataURL;
  final response = await http.post(dataURL ,
    headers: {'access_token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NTg5NDIyMjYsIm5iZiI6MTU1ODk0MjIyNiwianRpIjoiYVdOdmJXVnlYM1J2YTJWdVNVUT0iLCJleHAiOjE1OTAwNDYyMjYsImVtYWlsIjoia2RtNzE3M0BnbWFpbC5jb20ifQ.VfuUXV3Tc0e5rMSecrsFrPI64YmROLnIMW6pkns_4OE'},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    Book_today bookToday = new Book_today.fromJson(jsonResponse['daily_today']);

    //print(post.first.dial_00);

    return bookToday;

  } else {
    throw Exception('Failed to load post');
  }

}
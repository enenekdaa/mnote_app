import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/book_model.dart';
/*
*  작가목록 클릭시 ..
*  작가필명이 파라미터래 ex) writerAllList.elementAt(i).witer_name <<< 얘가 파라미터임 ㅇㅇ
* */
//    onPressed: () => getBookOtherList('http://icomerict.cafe24.com/untitled_note/json/books_other.php').then((bookOtherList) {
//      print('로 그  : : : : : ' + bookOtherList.elementAt(0).book_cover_img_no);
//    }),
//String dataURL = "http://icomerict.cafe24.com/checkcheck/json/check_result.php?name_0=%EB%82%B4%EC%9D%B4%EB%A6%84&birth_date_0=1991-05-24&birth_hour_0=0&cal_style_0=0&name_1=%EC%83%81%EB%8C%80%EC%9D%B4%EB%A6%84&birth_date_1=1991-05-24&birth_hour_1=13&cal_style_1=0&check_style=1";

String resultURL;
Future<List<BookModel>> getBookOtherList(String dataURL) async {
  resultURL = dataURL;

  final response = await http.post(dataURL ,
    headers: {'access_token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NTg5NDIyMjYsIm5iZiI6MTU1ODk0MjIyNiwianRpIjoiYVdOdmJXVnlYM1J2YTJWdVNVUT0iLCJleHAiOjE1OTAwNDYyMjYsImVtYWlsIjoia2RtNzE3M0BnbWFpbC5jb20ifQ.VfuUXV3Tc0e5rMSecrsFrPI64YmROLnIMW6pkns_4OE'},
    body: {'email' : 'dev.support@icomer.com' },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    final items = (jsonResponse['books_other'] as List).map((i) => new BookModel.fromJson(i));
    //print(post.first.dial_00);
    return items.toList();

  } else {
    throw Exception('Failed to load post');
  }

}

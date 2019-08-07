import 'dart:convert';
import 'package:mnote_app/model/book_model.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<BookModel> getBookInfoItem(String book_no) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_my_book_detail.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken}, body: {'book_no' : book_no},);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    BookModel bookInfo = BookModel.fromJson(jsonResponse['book_info']);
    print(jsonResponse['book_info']);
    return bookInfo;

  } else {
    throw Exception('Failed to load post');
  }
}

Future<List<ChapterModel>> getBookDetailItems(String bookNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_my_book_detail.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken}, body: {'book_no' : bookNo},);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    final items = (jsonResponse['book_detail'] as List).map((i) => new ChapterModel.fromJson(i));
    return items.toList();

  } else {
    throw Exception('Failed to load post');
  }
}


Future<BookModel> getDailyInfoItem() async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken});

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    BookModel bookInfo = BookModel.fromJson(jsonResponse['book_info']);
    print(jsonResponse['book_info']);
    return bookInfo;

  } else {
    throw Exception('Failed to load post');
  }

}

Future<List<ChapterModel>> getDailyDetailItems() async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_my_writings.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken});

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final items = (jsonResponse['book_detail'] as List).map((i) => new ChapterModel.fromJson(i));
    return items.toList();

  } else {
    throw Exception('Failed to load post');
  }

}
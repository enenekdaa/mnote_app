import 'dart:convert';
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/utils/mnote.dart';

Future<ChapterModel> getChapterDetail(String bookNo, String chapterNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_chapter_detail.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'book_no' : bookNo , 'chapter_no' : chapterNo },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    ChapterModel chapterDetail = new ChapterModel.fromJson(jsonResponse['chapter_detail']);
    return chapterDetail;

  } else {
    throw Exception('Failed to load post');
  }

}
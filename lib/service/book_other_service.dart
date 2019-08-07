import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:mnote_app/utils/mnote.dart';
/*
 *  공개노트
 *  해당 작가의 노트 리스트 로드
 */

Future<List<BookModel>> getBookOtherList(String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email },
  );

  print(email);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    final items = (jsonResponse['books_other'] as List)
        .map((i) => new BookModel.fromJson(i));
    return items.toList();
  } else {
    throw Exception('Failed to load post');
  }
}

/*
 *  공개노트의 인트로 (소개화면)
 *  해당 작가의 노트 리스트에서 노트 클릭시 
 *  노트의 챕터 목록 나오는 화면 
 */
Future<BookModel> getBookOtherIntroList(String email, String bookNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other_intro.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email , 'book_no' : bookNo},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    BookModel bookOtherIntro = new BookModel.fromJson(jsonResponse['books_other_intro']);
    return bookOtherIntro;
  } else {
    throw Exception('Failed to load post');
  }
}



/*
 *  공개노트의 글 (view) 화면
 */

Future<List<ChapterModel>> getBookOtherWritingsDetail(String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_other_chapter_detail.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final items = (jsonResponse['book_detail'] as List).map((i) => new ChapterModel.fromJson(i));
    return items.toList();
  } else {
    throw Exception('Failed to load post');
  }

}


/*
 *  공개노트의 하루글감 목록 화면
 */

Future<BookModel> getBookOtherWritings(String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_other_writings.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'email' : email},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    BookModel bookOtherWritings = new BookModel.fromJson(jsonResponse['book_info']);
    return bookOtherWritings;

  } else {
    throw Exception('Failed to load post');
  }

}
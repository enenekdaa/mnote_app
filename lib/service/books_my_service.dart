import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<List<BookModel>> getBooksMy() async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/books_my.php';
  final response = await http.post(dataURL ,
  headers: {'access_token' : Mnote.accessToken},
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final items = (jsonResponse['books_my'] as List).map((i) => new BookModel.fromJson(i));
    return items.toList();
  } else {
    print('getMyNoteBookList() fail');
    return [];
  }
}

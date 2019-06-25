import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/writer_all.dart';
import 'package:mnote_app/utils/mnote.dart';

// 작가 리스트 전체
Future<List<WriterAll>> getWriterListAll(String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/writer_list_all.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'page_no' : pageNo},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final items = (jsonResponse['writer_list'] as List).map((i) => new WriterAll.fromJson(i));
    return items.toList();

  } else {
    throw Exception('Failed to load post');
  }

}

// 구독 작가 목록
Future<List<WriterAll>> getWriterListSub(String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/writer_list_sub.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'page_no' : pageNo},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (!jsonResponse.toString().contains('my_sub_list')){
      return [];
    }
    final items = (jsonResponse['my_sub_list'] as List).map((i) => new WriterAll.fromJson(i));
    return items.toList();

  } else {
    throw Exception('Failed to load post');
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/daily_writings.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<List<DailyWritings>> getDailyWritings(String dailyListNo, String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_writings.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'daily_list_no': '4'/*dailyListNo*/, 'page_no': pageNo}
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    final items = (jsonResponse['daily_writings'] as List).map((i) => new DailyWritings.fromJson(i));
    return items.toList();
  } else {
    throw Exception('Failed to load post');
  }
}

Future<List<DailyWritings>> getDailyTodayWritings(String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_today_writings.php';
  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'page_no': pageNo}
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    final items = (jsonResponse['daily_today_writings'] as List).map((i) => new DailyWritings.fromJson(i));
    return items.toList();
  } else {
    throw Exception('Failed to load post');
  }
}

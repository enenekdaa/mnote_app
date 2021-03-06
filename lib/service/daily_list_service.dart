import 'dart:convert';
import 'package:mnote_app/model/daily_model.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/utils/mnote.dart';

Future<List<DailyModel>> getDailyList(String pageNo, {String search}) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_list.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: search == null
        ? {'page_no': pageNo}
        : {'page_no': pageNo, 'search': search},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final items = (jsonResponse['daily_list'] as List)
        .map((i) => new DailyModel.fromJson(i));
    return items.toList();
  } else {
    throw Exception('Failed to load post');
  }
}

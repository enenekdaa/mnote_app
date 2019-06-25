import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<DailyModel> getDailyToday() async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_today.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken},);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    DailyModel bookToday = new DailyModel.fromJson(jsonResponse['daily_today']);
    return bookToday;
  } else {
    throw Exception('Failed to load post');
  }
}
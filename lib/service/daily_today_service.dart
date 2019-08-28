import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/daily_model.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<DailyModel> getDailyToday(BuildContext context,) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_today.php';
  final response = await http.post(dataURL, headers: {'access_token' : Mnote.accessToken},);

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    DailyModel bookToday = new DailyModel.fromJson(jsonResponse['daily_today']);
    return bookToday;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getDailyToday(context);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}
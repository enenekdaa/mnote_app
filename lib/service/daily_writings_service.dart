import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/daily_writings.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<List<DailyWritings>> getDailyWritings(BuildContext context, String dailyListNo, String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_writings.php';
  final response = await http.post(dataURL ,
      headers: {'access_token' : Mnote.accessToken},
      body: {'daily_list_no': dailyListNo, 'page_no': pageNo}
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    final items = (jsonResponse['daily_writings'] as List).map((i) => new DailyWritings.fromJson(i));
    return items.toList();
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getDailyWritings(context, dailyListNo, pageNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

Future<List<DailyWritings>> getDailyTodayWritings(BuildContext context, String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/daily_today_writings.php';
  final response = await http.post(dataURL ,
      headers: {'access_token' : Mnote.accessToken},
      body: {'page_no': pageNo}
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    final items = (jsonResponse['daily_today_writings'] as List).map((i) => new DailyWritings.fromJson(i));
    return items.toList();
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getDailyTodayWritings(context, pageNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

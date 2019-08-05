import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/utils/mnote.dart';

String resultURL;

// url = http://icomerict.cafe24.com/untitled_note/sign_in/refresh_token.php
// result ==.. true = 성공 / false = 실패
// access_token / refresh_token 받음

Future<SignModel> getRefreshToken(String dataURL) async {
  resultURL = dataURL;
  final response = await http.post(dataURL ,
    // headers: {'refresh_token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NjA5MDQ3MjUsIm5iZiI6MTU2MDkwNDcyNSwianRpIjoiYVdOdmJXVnlYM1J2YTJWdVNVUT0iLCJleHAiOjE1NjM0OTY3MjUsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSJ9.xVDDehQGraB9CstC1Rc7FWcjqlLz1OxdK3UgFFvUSBo'},
    headers: {'refresh_token' : Mnote.refreshToken},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    SignModel signUpModel = new SignModel.fromJson(jsonResponse);
    return signUpModel;
  } else {
    throw Exception('Failed to load post');
  }
}